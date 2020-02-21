import UIKit
import SwiftAlgorithmsUserInterface
import SwiftAlgorithmsDataLayer

@available(macCatalyst 10.15, iOS 13, *)
protocol CatalystSearchPresenterDispatching: AnyObject {
    func didSelect(algorithm: Algorithm)
    func didSelect(dataStructure: DataStructure)
    func didSelect(puzzle: Puzzle)
}

fileprivate extension CatalystSearchResultsPresenter {
    struct State {
        enum Action {
            case selectedAlgorithm(Algorithm)
            case selectedDataStructure(DataStructure)
            case selectedPuzzle(Puzzle)
        }
        
        var algorithms: [Algorithm]
        var dataStructures: [DataStructure]
        var puzzles: [Puzzle]
        var searchedForTerm: String
        var actionLookup: [UUID: Action]
        static let initial = State(algorithms: [], dataStructures: [], puzzles: [], searchedForTerm: "", actionLookup: [:])
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
        var searchRows = [CatalystSearchResultsTableViewController.Properties.SectionProperties.RowProperties]()
        searchRows.append(contentsOf: state.algorithms.compactMap {
            
            if let searchTerm = searchTerm, $0.title.lowercased().contains(searchTerm) == false {
                return nil
            }
            
            let id = UUID()
            state.actionLookup[id] = .selectedAlgorithm($0)
            return Self.makeIdentifiableAction(for: $0, searchTerm: searchTerm, with: id)
        })
        
        searchRows.append(contentsOf: state.dataStructures.compactMap {
            
            if let searchTerm = searchTerm, $0.title.lowercased().contains(searchTerm) == false {
                return nil
            }
            let id = UUID()
            state.actionLookup[id] = .selectedDataStructure($0)
            return Self.makeIdentifiableAction(for: $0, searchTerm: searchTerm, with: id)
        })
        
        searchRows.append(contentsOf: state.puzzles.compactMap {
            
            if let searchTerm = searchTerm, $0.title.lowercased().contains(searchTerm) == false {
                return nil
            }
            let id = UUID()
            state.actionLookup[id] = .selectedPuzzle($0)
            return Self.makeIdentifiableAction(for: $0, searchTerm: searchTerm, with: id)
        })
        
        return (state, .init(sections: [.init(sectionTitle: "",
                                              rows: searchRows)]))
    }
    
    private static func makeInitialState() -> State {
        State(algorithms: AlgorithmType.allCases(),
              dataStructures: DataStructure.allCases,
              puzzles: Puzzle.allCases,
              searchedForTerm: "",
              actionLookup: [:])
    }
    
    private static func makeIdentifiableAction(for algorithm: Algorithm,
                                               searchTerm: String?,
                                               with identifier: UUID) -> CatalystSearchResultsTableViewController.Properties.SectionProperties.RowProperties {
        CatalystSearchResultsTableViewController.Properties.SectionProperties.RowProperties(title: algorithm.title,
                                                                                            iconProperties: .init(background: algorithm.category.color,
                                                                                                                  icon: algorithm.category.image),
                                                                                            subtitle: algorithm.subtitle,
                                                                                            identifier: identifier)
    }
    
    private static func makeIdentifiableAction(for dataStructure: DataStructure,
                                               searchTerm: String?,
                                               with identifier: UUID) -> CatalystSearchResultsTableViewController.Properties.SectionProperties.RowProperties {
        CatalystSearchResultsTableViewController.Properties.SectionProperties.RowProperties(title: dataStructure.title,
                                                                                            iconProperties: .init(background: dataStructure.category?.color ?? .systemGray2,
                                                                                                                  icon: dataStructure.category?.image ?? UIImage()),
                                                                                            subtitle: dataStructure.subtitle,
                                                                                            identifier: identifier)
    }
    
    
    private static func makeIdentifiableAction(for puzzle: Puzzle,
                                               searchTerm: String?,
                                               with identifier: UUID) -> CatalystSearchResultsTableViewController.Properties.SectionProperties.RowProperties {
        CatalystSearchResultsTableViewController.Properties.SectionProperties.RowProperties(title: puzzle.title,
                                                                                            iconProperties: .init(background: .systemTeal,
                                                                                                                  icon: UIImage(named: "puzzle")),
                                                                                            subtitle: puzzle.subtitle,
                                                                                            identifier: identifier)
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
