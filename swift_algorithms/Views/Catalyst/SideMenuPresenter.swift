import Foundation

protocol SideMenuPresenterDelegate {
    func didSelect(algorithmCatgory: AlgorithmCategory)
    func didSelect(dataStructureCategory: DataStructure.Category)
    func didSelect(puzzle: Puzzle)
}

final class SideMenuPresenter {
    
    private var puzzleLookup = [UUID: Puzzle]()
    private var dataStructureCategoryLookup = [UUID: DataStructure.Category]()
    private var algorithmCategoryLookup = [UUID: AlgorithmCategory]()
    var delegate: SideMenuPresenterDelegate?
    weak var renderer: SideMenuTableViewRendering?
    weak var categoryRenderer: CategoryArticleListViewRendering?
    weak var markdownRenderer: MarkdownPresentationViewRendering?
    
    var algorithmLookup = [UUID: AlgorithmPresentationAction]()
    var dataStructureLookup = [UUID: DataStructurePresenter.Action]()
    
    
    init() {

    }
    
    deinit {
        
    }
}

extension SideMenuPresenter: CategoryArticleListViewDelegate {
    func didSelectArticle(with identifier: UUID){
        if case let .selectedAlgorithm(algorithm) = algorithmLookup[identifier] {
            markdownRenderer?.setMarkdown(for: algorithm)
        } else if case let .selectedDataStructure(`struct`) = dataStructureLookup[identifier] {
            markdownRenderer?.setMarkdown(for: `struct`)
        }
    }
}

extension SideMenuPresenter: SideMenuViewDelegate {
    func didSelectItem(with identifier: UUID) {
        if let puzzle = puzzleLookup[identifier] {
            delegate?.didSelect(puzzle: puzzle)
        } else if let dataStructure = dataStructureCategoryLookup[identifier] {
            let section = DataStructureSectionFactory().makeDataStructureSection(for: dataStructure)
            for (key, value) in section.identifiers {
                dataStructureLookup[key] = value
            }
            categoryRenderer?.sections = [section.seciton]
        } else if let algorithm = algorithmCategoryLookup[identifier] {
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
        let category: [SideMenuItemCell.Properties] = AlgorithmCategory.allCases.map {
            let id = UUID()
            algorithmCategoryLookup[id] = $0
            
            return SideMenuItemCell.Properties(iconProperties: .init(background: $0.color,
                                                                     icon: $0.image),
                                               name: $0.title,
                                               identifier: id)
        }
        
        let ds: [SideMenuItemCell.Properties] = DataStructure.Category.allCases.map {
            let id = UUID()
            dataStructureCategoryLookup[id] = $0
            return SideMenuItemCell.Properties(iconProperties: .init(background: $0.color,
                                                                     icon: $0.image),
                                               name: $0.title,
                                               identifier: id)
        }
        
        let puzzles: [SideMenuItemCell.Properties] = Puzzle.allCases.map {
            let id = UUID()
            puzzleLookup[id] = $0
            return SideMenuItemCell.Properties(iconProperties: nil, name: $0.title, identifier: id)
        }
        
        let properties = SideMenuTableViewController.Properties(sections: [
            .init(items: category, title: "Algorithms"),
            .init(items: ds, title: "Data Structures"),
            .init(items: puzzles, title: "Puzzles")
        ])
        
        renderer?.properties = properties
    }
}
