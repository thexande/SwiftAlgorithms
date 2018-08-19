import UIKit



protocol RowController: UITableViewDelegate, UITableViewDataSource {
    var dispatcher: RowActionDispatching? { get set }
    func registerReusableTypes(tableView: UITableView)
}


protocol RowActionDispatching: AnyObject {
    func dispatch(_ action: AlgorithmViewController.Action)
}

final class ActionTableSectionController: NSObject, TableSectionController {
    public var rows: [RowController] = []
    public var sectionTitle: String?
    
    public weak var dispatcher: RowActionDispatching? {
        didSet {
            rows.forEach { row in
                row.dispatcher = dispatcher
            }
        }
    }
    
    func registerReusableTypes(tableView: UITableView) {
        rows.forEach { row in
            row.registerReusableTypes(tableView: tableView)
        }
    }
}

extension ActionTableSectionController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return rows[indexPath.row].tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (sectionTitle != nil) ? 38 : 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rows[indexPath.row].tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rows[indexPath.row].tableView?(tableView, heightForRowAt: indexPath) ?? UITableViewAutomaticDimension
    }
}

