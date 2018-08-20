import UIKit

final class ResultsTableViewController: SectionProxyTableViewController {
    private let empty = SearchEmptyStateView()
    
    weak var dispatcher: RowActionDispatching?
    
    var properties: [BasicTableRowController.Properties] = [] {
        didSet {
            update(with: properties)
        }
    }
    
    func update(with properties: [BasicTableRowController.Properties]) {
        
        let categories = Array(Set(properties.map { $0.action }.compactMap(AlgorithmViewController.Action.category(for:))))
        
        let sections: [TableSectionController] = categories.map { category in
            let sectionProperties = properties.filter {
                if let cat = $0.action.category {
                    return cat == category
                } else {
                    return false
                }
            }
            
            let section = BasicTableSectionController()
            section.sectionTitle = category.title
            section.rows = sectionProperties.map(SearchResultsRowController.map)
            section.registerReusableTypes(tableView: tableView)
            section.dispatcher = dispatcher
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

