import UIKit

final class BasicTableSectionController: NSObject, TableSectionController {
    public var rows: [RowController] = []
    public var sectionTitle: String?
    public var sectionSubtitle: String?
    
    public weak var dispatcher: RowActionDispatching? {
        didSet {
            rows.forEach { row in
                row.dispatcher = dispatcher
            }
        }
    }
    
    func registerReusableTypes(tableView: UITableView) {
        tableView.register(BasicTableHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: BasicTableHeaderView.self))
        
        rows.forEach { row in
            row.registerReusableTypes(tableView: tableView)
        }
    }
}

extension BasicTableSectionController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return rows[indexPath.row].tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (sectionTitle != nil) ? UITableViewAutomaticDimension : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: BasicTableHeaderView.self)) as? BasicTableHeaderView else {
            return nil
        }
        view.title = sectionTitle
        view.subtitle = sectionSubtitle
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rows[indexPath.row].tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rows[indexPath.row].tableView?(tableView, heightForRowAt: indexPath) ?? UITableViewAutomaticDimension
    }
}


