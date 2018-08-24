import UIKit

protocol AlgorithmSearchPresenterDispatching {
    func dispatch(_ action: AlgorithmSearchPresenter.Action)
}


final class AlgorithmSearchPresenter: NSObject, UISearchResultsUpdating, UISearchBarDelegate {
    
    enum Action {
        case selectedAlgorithm(Algorithm)
    }
    
    var actionLookup: [UUID: Action] = [:]
    
    var algorithms: [Algorithm] = []
    
    var deliver: (([SearchResultsTableViewController.Properties]) -> Void)?
    
    
    var searchedProperties: [SearchResultsTableViewController.Properties] = [] {
        didSet {
            deliver?(searchedProperties)
        }
    }

    func makeSearchableAlgorithmProperties() {
        let allAlgorithmProperties = Algorithm.allCases
        algorithms = allAlgorithmProperties
        searchedProperties = makeCategorySections(for: algorithms)
    }
    
    private func makeCategorySections(for algorithms: [Algorithm]) -> [SearchResultsTableViewController.Properties] {
        // reset action hash map
        actionLookup = [:]
        
        let categories = Algorithm.Category.allCases
        
        let categoryProps: [SearchResultsTableViewController.Properties] = categories.compactMap { category in
            
            let categoryAlgorithms = algorithms.filter { algorithm in
                
                guard
                    let algorithmCategory = Algorithm.category(for: algorithm),
                    algorithmCategory == category else {
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
                                                         indicatorColor: (algorithm.category?.color ?? .black),
                                                         identifier: identifier)
        
        actionLookup[identifier] = .selectedAlgorithm(algorithm)
        return prop
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            
            let searchedAlgorithms = algorithms.filter { algorithm in
                return "\(algorithm.title)\(algorithm.subtitle ?? "")".contains(text)
            }
            
            searchedProperties = makeCategorySections(for: searchedAlgorithms)
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
}
