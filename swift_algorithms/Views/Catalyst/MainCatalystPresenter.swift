import Foundation

@available(iOS 13.0, *)
protocol MainCatalystPresenterDelegate: AnyObject {
    func showCategorySelectorView()
    func showAboutView()
    func show(puzzle: Puzzle)
}

@available(iOS 13.0, *)
final class MainCatalystPresenter {
    
    private var state = State.initial
    
    weak var renderer: SideMenuTableViewRendering?
    weak var categoryRenderer: CategoryArticleListViewRendering?
    weak var markdownRenderer: MarkdownPresentationViewRendering?
    
    var algorithmLookup = [UUID: AlgorithmPresentationAction]()
    var dataStructureLookup = [UUID: DataStructurePresenter.Action]()
    weak var delegate: MainCatalystPresenterDelegate?
    
    private var isDisplayingCategory = false
}


// MARK: - State

fileprivate extension MainCatalystPresenter {
    struct State {
        var puzzleLookup: [UUID: Puzzle]
        var dataStructureCategoryLookup: [UUID: DataStructure.Category]
        var algorithmCategoryLookup: [UUID: AlgorithmCategory]
        static let initial = State(puzzleLookup: [:], dataStructureCategoryLookup: [:], algorithmCategoryLookup: [:])
    }
}

// MARK: - CategoryArticleListViewDelegate

@available(iOS 13.0, *)
extension MainCatalystPresenter: CategoryArticleListViewDelegate {
    func didSelectArticle(with identifier: UUID){
        if case let .selectedAlgorithm(algorithm) = algorithmLookup[identifier] {
            markdownRenderer?.setMarkdown(for: algorithm)
        } else if case let .selectedDataStructure(`struct`) = dataStructureLookup[identifier] {
            markdownRenderer?.setMarkdown(for: `struct`)
        }
    }
}

// MARK: - SideMenuViewDelegate

@available(iOS 13.0, *)
extension MainCatalystPresenter: SideMenuViewDelegate {
    func didSelectItem(with identifier: UUID) {
        if isDisplayingCategory == false {
            delegate?.showCategorySelectorView()
        }
        
        if let puzzle = state.puzzleLookup[identifier] {
            delegate?.show(puzzle: puzzle)
        } else if let dataStructure = state.dataStructureCategoryLookup[identifier] {
            let section = DataStructureSectionFactory().makeDataStructureSection(for: dataStructure)
            for (key, value) in section.identifiers {
                dataStructureLookup[key] = value
            }
            categoryRenderer?.sections = [section.seciton]
            categoryRenderer?.title = dataStructure.title
        } else if let algorithm = state.algorithmCategoryLookup[identifier] {
            let sections = AlgorithmSectionFactory().makeSections(for: algorithm)
            
            categoryRenderer?.sections = sections.map {
                for (key, value) in $0.identifiers {
                    algorithmLookup[key] = value
                }
                
                return $0.seciton
            }
            categoryRenderer?.title = algorithm.title
        }
    }
    
    func viewDidLoad() {
        let (state, properties) = MainCatalystPresenter.reduceSideMenuItems(state: self.state)
        self.state = state
        renderer?.properties = properties
    }
}

// MARK: - Reducers

extension MainCatalystPresenter {
    private static func reduceSideMenuItems(state: State) -> (state: State, viewProperties: SideMenuTableViewController.Properties) {
        var state = state
        
        let category: [SideMenuItemCell.Properties] = AlgorithmCategory.allCases.map {
            let id = UUID()
            state.algorithmCategoryLookup[id] = $0
            
            return SideMenuItemCell.Properties(iconProperties: .init(background: $0.color,
                                                                     icon: $0.image),
                                               name: $0.title,
                                               identifier: id)
        }
        
        let ds: [SideMenuItemCell.Properties] = DataStructure.Category.allCases.map {
            let id = UUID()
            state.dataStructureCategoryLookup[id] = $0
            return SideMenuItemCell.Properties(iconProperties: .init(background: $0.color,
                                                                     icon: $0.image),
                                               name: $0.title,
                                               identifier: id)
        }
        
        let puzzles: [SideMenuItemCell.Properties] = Puzzle.allCases.map {
            let id = UUID()
            state.puzzleLookup[id] = $0
            return SideMenuItemCell.Properties(iconProperties: nil, name: $0.title, identifier: id)
        }
        
        let properties = SideMenuTableViewController.Properties(sections: [
            .init(items: category, title: "Algorithms"),
            .init(items: ds, title: "Data Structures"),
            .init(items: puzzles, title: "Puzzles")
        ])
        
        return (state, properties)
    }
}
