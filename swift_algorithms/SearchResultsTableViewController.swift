import UIKit

final class SearchResultsTableViewController: SectionProxyTableViewController {
    
    struct Properties {
        let sectionTitle: String
        let rows: [SearchResultsRowController.Properties]
    }
    
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
            return section
        }

        self.sections = sections

        tableView.reloadData()
        
        if properties.count > 0 {
            tableView.backgroundView?.isHidden = true
        } else {
            empty.isHidden = false
            view.bringSubview(toFront: empty)
        }
    }
    
    override init(style: UITableViewStyle) {
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

