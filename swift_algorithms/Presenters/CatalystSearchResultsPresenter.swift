import UIKit
import SwiftAlgorithmsUserInterface
import SwiftAlgorithmsDataLayer

@available(macCatalyst 10.15, iOS 13, *)
protocol CatalystSearchPresenterDispatching: AnyObject {
    func didSelect(algorithm: Algorithm)
    func didSelect(dataStructure: DataStructure)
    func didSelect(puzzle: Puzzle)
}

@available(macCatalyst 10.15, iOS 13, *)
fileprivate extension CatalystSearchResultsPresenter {
    struct State {
        enum Action {
            case selectedAlgorithm(Algorithm)
            case selectedDataStructure(DataStructure)
            case selectedPuzzle(Puzzle)
        }
        
        var algorithms: [Algorithm]
        var algorithmResourceUrlLookup: [String: UUID]
        var dataStructures: [DataStructure]
        var dataStructureResourceUrlLookup: [String: UUID]
        var puzzles: [Puzzle]
        var puzzleResourceUrlLookup: [String: UUID]
        var searchedForTerm: String
        var actionLookup: [UUID: Action]
        static let initial = State(algorithms: [],
                                   algorithmResourceUrlLookup: [:],
                                   dataStructures: [],
                                   dataStructureResourceUrlLookup: [:],
                                   puzzles: [],
                                   puzzleResourceUrlLookup: [:],
                                   searchedForTerm: "",
                                   actionLookup: [:])
    }
}

fileprivate extension AlgorithmCategory {
    func identifier() -> CatalystSearchResultsTableViewController.Properties.Item.Identifier {
        switch self {
        case .compression:
            return .compression
        case .gettingStarted:
            return .gettingStarted
        case .machineLearning:
            return .machineLearning
        case .math:
            return .math
        case .misc:
            return .miscellaneous
        case .searching:
            return .searching
        case .sorting:
            return .sorting
        case .stringSearch:
            return .stringSearch
        }
    }
}

fileprivate extension DataStructure.Category {
    func identifier() -> CatalystSearchResultsTableViewController.Properties.Item.Identifier {
        switch self {
        case .array:
            return .arrays
        case .graph:
            return .graphs
        case .hash:
            return .hashes
        case .list:
            return .lists
        case .queue:
            return .queues
        case .set:
            return .sets
        case .tree:
            return .trees
        }
    }
}

@available(macCatalyst 10.15, iOS 13, *)
final class CatalystSearchResultsPresenter {
    weak var delegate: CatalystSearchPresenterDispatching?
    weak var renderer: CatalystSearchResultsTableViewRendering?
    private var state = State.initial
    
    private static func mapStateToViewProperties(with searchTerm: String?,
                                                 state: State) -> (state: State, viewProperties: CatalystSearchResultsTableViewController.Properties) {
        var state = state
        var items = [CatalystSearchResultsTableViewController.Properties.Item]()
        
        let algorithmItems: [CatalystSearchResultsTableViewController.Properties.Item] = state.algorithms.compactMap {
            if let searchTerm = searchTerm, $0.title.lowercased().contains(searchTerm) == false {
                return nil
            }
            
            guard let id = state.algorithmResourceUrlLookup[$0.resourceUrl] else { return nil }
            
            state.actionLookup[id] = .selectedAlgorithm($0)
            return Self.makeIdentifiableAction(for: $0, searchTerm: searchTerm, with: id)
        }
        
        items.append(contentsOf: algorithmItems)
        
        let dataStructureItems: [CatalystSearchResultsTableViewController.Properties.Item] = state.dataStructures.compactMap {
            
            if let searchTerm = searchTerm, $0.title.lowercased().contains(searchTerm) == false {
                return nil
            }
            
            guard let id = state.dataStructureResourceUrlLookup[$0.resourceUrl] else { return nil }
            state.actionLookup[id] = .selectedDataStructure($0)
            return Self.makeIdentifiableAction(for: $0, searchTerm: searchTerm, with: id)
        }
        
        items.append(contentsOf: dataStructureItems)
        
        let puzzleItems: [CatalystSearchResultsTableViewController.Properties.Item] = state.puzzles.compactMap {
            
            if let searchTerm = searchTerm, $0.title.lowercased().contains(searchTerm) == false {
                return nil
            }
            guard let id = state.puzzleResourceUrlLookup[$0.resourceUrl] else { return nil }
            state.actionLookup[id] = .selectedPuzzle($0)
            return Self.makeIdentifiableAction(for: $0, searchTerm: searchTerm, with: id)
        }
        
        items.append(contentsOf: puzzleItems)
        
        return (state, .init(items: items))
    }
    
    private static func makeInitialState() -> State {
        let algorithms = AlgorithmType.allCases()
        let algorithmLookup = algorithms.reduce(into: [String: UUID]()) { lookup, algorithm in
            lookup[algorithm.resourceUrl] = UUID()
        }
        
        let dataStructures = DataStructure.allCases
        let dataStructureLookup = dataStructures.reduce(into: [String: UUID]()) { lookup, ds in
            lookup[ds.resourceUrl] = UUID()
        }
        
        let puzzles = Puzzle.allCases
        let puzzleLookup = puzzles.reduce(into: [String: UUID]()) { lookup, puzzle in
            lookup[puzzle.resourceUrl] = UUID()
        }
        
        return State(algorithms: algorithms,
                     algorithmResourceUrlLookup: algorithmLookup,
                     dataStructures: dataStructures,
                     dataStructureResourceUrlLookup: dataStructureLookup,
                     puzzles: puzzles, puzzleResourceUrlLookup: puzzleLookup,
                     searchedForTerm: "",
                     actionLookup: [:])
    }
    
    private static func makeIdentifiableAction(for algorithm: Algorithm,
                                               searchTerm: String?,
                                               with identifier: UUID) -> CatalystSearchResultsTableViewController.Properties.Item {
        CatalystSearchResultsTableViewController.Properties.Item(title: algorithm.title,
                                                                 iconProperties: .init(background: algorithm.category.color,
                                                                                       icon: algorithm.category.image),
                                                                 subtitle: algorithm.subtitle,
                                                                 identifier: identifier,
                                                                 sectionIdentifier: algorithm.category.identifier())
    }
    
    private static func makeIdentifiableAction(for dataStructure: DataStructure,
                                               searchTerm: String?,
                                               with identifier: UUID) -> CatalystSearchResultsTableViewController.Properties.Item {
        CatalystSearchResultsTableViewController.Properties.Item(title: dataStructure.title,
                                                                 iconProperties: .init(background: dataStructure.category?.color ?? .systemGray2,
                                                                                       icon: dataStructure.category?.image ?? UIImage()),
                                                                 subtitle: dataStructure.subtitle,
                                                                 identifier: identifier,
                                                                 sectionIdentifier: dataStructure.category?.identifier() ?? .gettingStarted)
    }
    
    
    private static func makeIdentifiableAction(for puzzle: Puzzle,
                                               searchTerm: String?,
                                               with identifier: UUID) -> CatalystSearchResultsTableViewController.Properties.Item {
        CatalystSearchResultsTableViewController.Properties.Item(title: puzzle.title,
                                                                 iconProperties: .init(background: .systemTeal,
                                                                                       icon: UIImage(named: "puzzle")),
                                                                 subtitle: puzzle.subtitle,
                                                                 identifier: identifier,
                                                                 sectionIdentifier: .puzzles)
    }
}

@available(macCatalyst 10.15, iOS 13, *)
extension CatalystSearchResultsPresenter: CatalystSearchResultsTableViewDelegate {
    func searched(for term: String) {
        let term: String? = term.isEmpty ? nil : term
        let (state, viewProperties) = CatalystSearchResultsPresenter.mapStateToViewProperties(with: term,
                                                                                              state: self.state)
        self.state = state
        renderer?.properties = viewProperties
    }
    
    func selectedItem(with identifier: UUID) {
        guard let action = state.actionLookup[identifier] else { return }
        switch action {
        case .selectedAlgorithm(let algorithm):
            delegate?.didSelect(algorithm: algorithm)
        case .selectedDataStructure(let dataStructure):
            delegate?.didSelect(dataStructure: dataStructure)
        case .selectedPuzzle(let puzzle):
            delegate?.didSelect(puzzle: puzzle)
        }
    }
    
    func viewDidLoad() {
        let (state, viewProperties) = CatalystSearchResultsPresenter.mapStateToViewProperties(with: nil,
                                                                                              state: Self.makeInitialState())
        self.state = state
        renderer?.properties = viewProperties
    }
}
