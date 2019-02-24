import UIKit

protocol AlgorithmSearchPresenterDispatching: AnyObject {
    func dispatch(_ action: AlgorithmSearchPresenter.Action)
}

final class AlgorithmSearchPresenter {
    
    enum Action {
        case selectedAlgorithm(Algorithm)
    }
    
    weak var dispatcher: AlgorithmSearchPresenterDispatching?
    
    var actionLookup: [UUID: Action] = [:]
    
    var algorithms: [Algorithm] = []
    
    var deliver: (([SearchResultsTableViewController.Properties]) -> Void)?
    
    
    var searchedProperties: [SearchResultsTableViewController.Properties] = [] {
        didSet {
            deliver?(searchedProperties)
        }
    }

    func makeSearchableAlgorithmProperties() {
        let allAlgorithmProperties = AlgorithmType.allCases()
        algorithms = allAlgorithmProperties
        searchedProperties = makeCategorySections(for: algorithms)
    }
    
    private func makeCategorySections(for algorithms: [Algorithm]) -> [SearchResultsTableViewController.Properties] {
        // reset action hash map
        actionLookup = [:]
        
        let categories = AlgorithmCategory.allCases
        
        let categoryProps: [SearchResultsTableViewController.Properties] = categories.compactMap { category in
            
            let categoryAlgorithms = algorithms.filter { algorithm in
                
                guard
                    algorithm.category == category else {
                        return false
                }
                
                return true
            }
            
            let categoryAlgorithmRowProps = categoryAlgorithms.map(makeIdentifiableAction(for:))
            
            let props = SearchResultsTableViewController.Properties(sectionTitle: category.title,
                                                              rows: categoryAlgorithmRowProps)
            
            guard categoryAlgorithmRowProps.count > 0 else {
                return nil
            }
            
            return props
        }
        
        return categoryProps
    }
    
    private func makeIdentifiableAction(for algorithm: Algorithm) -> SearchResultsRowController.Properties {
        let identifier = UUID()
        let prop = SearchResultsRowController.Properties(title: algorithm.title,
                                                         indicatorColor: (algorithm.category.color),
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
            return "\(algorithm.title)\(algorithm.subtitle ?? "")".contains(term)
        }
        
        searchedProperties = makeCategorySections(for: searchedAlgorithms)
    }
    
    private func handleSelected(with identifier: UUID) {
        guard let action = actionLookup[identifier] else {
            return
        }
        
        dispatcher?.dispatch(action)
    }
}

extension AlgorithmSearchPresenter: SearchActionDispatching {
    func dispatch(_ action: SearchResultsTableViewController.Action) {
        switch action {
        case let .searchedTerm(term):
            handleSearch(term)
        case let .selectedTerm(identifier):
            handleSelected(with: identifier)
        }
    }
}
