import UIKit



protocol SearchActionDispatching: AnyObject {
    func dispatch(_ action: SearchResultsTableViewController.Action)
}

final class SearchResultsTableViewController: SectionProxyTableViewController {
    
    enum Action {
        case searchedTerm(String)
        case selectedTerm(UUID)
    }
    
    struct Properties {
        let sectionTitle: String
        let rows: [SearchResultsRowController.Properties]
    }
    
    weak var dispatcher: SearchActionDispatching?
    
    private let empty = SearchEmptyStateView()
    
    var properties: [Properties] = [] {
        didSet {
            update(with: properties)
        }
    }
    
    private func update(with properties: [Properties]) {
        
        
        let sections: [TableSectionController] = properties.map { prop in
           
            let section = BasicTableSectionController()
            
            section.sectionTitle = prop.sectionTitle
            section.rows = prop.rows.map(SearchResultsRowController.map)
            section.registerReusableTypes(tableView: tableView)
            
            section.onSelect = { [weak self] identifier in
                self?.dispatcher?.dispatch(.selectedTerm(identifier))
            }
            
            return section
        }

        self.sections = sections

        tableView.reloadData()
        
        if properties.count > 0 {
            tableView.backgroundView?.isHidden = true
        } else {
            empty.isHidden = false
            view.bringSubviewToFront(empty)
        }
    }
    
    override init(style: UITableView.Style) {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.backgroundView = empty
        tableView.backgroundView?.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        empty.removeFromSuperview()
    }
}

extension SearchResultsTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        view.isHidden = false
        if let text = searchController.searchBar.text {
            dispatcher?.dispatch(.searchedTerm(text))
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

