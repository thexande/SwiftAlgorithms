import UIKit
import SwiftAlgorithmsUserInterface

protocol CatalystAlgorithmSearchPresenterDispatching: AnyObject {
    func didSelect(algorithm: Algorithm)
    func didSelect(dataStructure: DataStructure)
    func didSelect(puzzle: Puzzle)
}

final class CatalystAlgorithmSearchPresenter {
    
    enum Action {
        case selectedAlgorithm(Algorithm)
    }
    
    var actionLookup: [UUID: Action] = [:]
    var algorithms: [Algorithm] = []
    weak var delegate: CatalystAlgorithmSearchPresenterDispatching?
    weak var renderer: CatalystSearchResultsTableViewRendering?
    
    var searchedProperties: CatalystSearchResultsTableViewController.Properties = .default {
        didSet {
            renderer?.properties = searchedProperties
        }
    }

    func makeSearchableAlgorithmProperties() {
        let allAlgorithmProperties = AlgorithmType.allCases()
        algorithms = allAlgorithmProperties
        searchedProperties = makeCategorySections(for: algorithms)
    }
    
    private func makeCategorySections(for algorithms: [Algorithm]) -> CatalystSearchResultsTableViewController.Properties {
        // reset action hash map
        actionLookup = [:]
        
        let categories = AlgorithmCategory.allCases
        
        let categoryProps: [CatalystSearchResultsTableViewController.Properties.SectionProperties] = categories.compactMap { category in
            
            let categoryAlgorithms = algorithms.filter { algorithm in
                
                guard
                    algorithm.category == category else {
                        return false
                }
                
                return true
            }
            
            let categoryAlgorithmRowProps = categoryAlgorithms.map(makeIdentifiableAction(for:))
            
            let props = CatalystSearchResultsTableViewController.Properties.SectionProperties(sectionTitle: category.title,
                                                              rows: categoryAlgorithmRowProps)
            
            guard categoryAlgorithmRowProps.count > 0 else {
                return nil
            }
            
            return props
        }
        
        return .init(sections: categoryProps)
    }
    
    private func makeIdentifiableAction(for algorithm: Algorithm) -> CatalystSearchResultsTableViewController.Properties.SectionProperties.RowProperties {
        let identifier = UUID()
        let prop = CatalystSearchResultsTableViewController.Properties.SectionProperties.RowProperties(title: algorithm.title,
                                                                                                       iconProperties: .init(background: algorithm.category.color, icon: algorithm.category.image),
                                                                                                       subtitle: algorithm.subtitle,
                                                                                                       identifier: identifier)
        
        actionLookup[identifier] = .selectedAlgorithm(algorithm)
        return prop
    }
    
    private func handleSearch(_ term: String) {
        
        if term == "" {
            let all = makeCategorySections(for: algorithms)
            searchedProperties = all
            return
        }
        
        let searchedAlgorithms = algorithms.filter { algorithm in
            return "\(algorithm.title)\(algorithm.subtitle ?? "")".lowercased().contains(term.lowercased())
        }
        
        searchedProperties = makeCategorySections(for: searchedAlgorithms)
    }
    
    private func handleSelected(with identifier: UUID) {
        guard let action = actionLookup[identifier] else { return }
        
        switch action {
        case.selectedAlgorithm(let algorithm):
            delegate?.didSelect(algorithm: algorithm)
        }
    }
}

extension CatalystAlgorithmSearchPresenter: CatalystSearchResultsTableViewDelegate {
    func searched(for term: String) {
        handleSearch(term)
    }
    
    func selectedItem(with identifier: UUID) {
        handleSelected(with: identifier)
    }
    
    func viewDidLoad() {
        makeSearchableAlgorithmProperties()
    }
}
