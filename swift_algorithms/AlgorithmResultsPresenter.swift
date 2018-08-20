import UIKit

final class AlgorithmResultsPresenter: NSObject, UISearchResultsUpdating, UISearchBarDelegate {
    
    var properties: [BasicTableRowController.Properties] = []
    var deliver: (([BasicTableRowController.Properties]) -> Void)?
    
    var searchedProperties: [BasicTableRowController.Properties] = [] {
        didSet {
            deliver?(searchedProperties)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            searchedProperties = properties.filter { item in
                return (item.title + (item.subtitle ?? "")).lowercased().contains(text.lowercased())
            }
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
