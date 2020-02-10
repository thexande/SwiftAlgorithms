import Foundation

@available(iOS 13.0, *)
protocol MainCatalystPresenterDelegate: AnyObject {
    func showCategorySelectorViewWithAbout()
    func showCategorySelectorViewWithMarkdown()
    func showAboutView()
    func show(puzzle: Puzzle)
}

@available(iOS 13.0, *)
final class MainCatalystPresenter {
    
    private var state = State.initial {
        didSet {
            switch state.presentation {
            case.sideAndAbout:
                break
            case .sideAndCategoryWithMarkdown:
                delegate?.showCategorySelectorViewWithMarkdown()
            case .sideAndCategoryWithAbout:
                delegate?.showCategorySelectorViewWithAbout()
            case .sideAndPuzzle(let puzzle):
                delegate?.show(puzzle: puzzle)
            }
        }
    }
    
    weak var renderer: SideMenuTableViewRendering?
    weak var categoryRenderer: CategoryArticleListViewRendering?
    weak var markdownRenderer: MarkdownPresentationViewRendering?
    
    var algorithmLookup = [UUID: AlgorithmPresentationAction]()
    var dataStructureLookup = [UUID: DataStructurePresenter.Action]()
    weak var delegate: MainCatalystPresenterDelegate?
    
    private var isDisplayingCategory = false
}


// MARK: - State

@available(iOS 13.0, *)
fileprivate extension MainCatalystPresenter {
    struct State {
        enum Presentation {
            case sideAndAbout
            case sideAndPuzzle(Puzzle)
            case sideAndCategoryWithAbout
            case sideAndCategoryWithMarkdown
        }
        var presentation = Presentation.sideAndAbout
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
        state = MainCatalystPresenter.reduce(presentationChange: .sideAndCategoryWithMarkdown, from: state)
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
        if let puzzle = state.puzzleLookup[identifier] {
            state = Self.reduce(presentationChange: .sideAndPuzzle(puzzle), from: state)
        } else if let dataStructure = state.dataStructureCategoryLookup[identifier] {
            state = Self.reduce(presentationChange: .sideAndCategoryWithAbout, from: state)
            let section = DataStructureSectionFactory().makeDataStructureSection(for: dataStructure)
            
            for (key, value) in section.identifiers {
                dataStructureLookup[key] = value
            }
            categoryRenderer?.sections = [section.seciton]
            categoryRenderer?.title = dataStructure.title
        } else if let algorithm = state.algorithmCategoryLookup[identifier] {
            state = Self.reduce(presentationChange: .sideAndCategoryWithAbout, from: state)
            
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

@available(iOS 13.0, *)
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
    
    private static func reduce(presentationChange: State.Presentation, from state: State) -> State {
        var state = state
        state.presentation = presentationChange
        return state
    }
}
