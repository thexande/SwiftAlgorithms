import UIKit

final class ResultsTableViewController: SectionProxyTableViewController {
    private let section = BasicTableSectionController()
    private let empty = SearchEmptyStateView()
    
    weak var dispatcher: RowActionDispatching?
    
    var properties: [BasicTableRowController.Properties] = [] {
        didSet {
            update(with: properties.map(BasicTableRowController.map))
        }
    }
    
    func update(with properties: [RowController]) {
        section.rows = properties
        section.dispatcher = dispatcher
        tableView.reloadData()
        
        if properties.count > 0 {
            tableView.backgroundView?.isHidden = true
        } else {
            empty.isHidden = false
            view.bringSubview(toFront: empty)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        section.registerReusableTypes(tableView: tableView)
        sections = [section]
        tableView.tableFooterView = UIView()
        tableView.backgroundView = empty
        tableView.backgroundView?.isHidden = true
        
    }
}

