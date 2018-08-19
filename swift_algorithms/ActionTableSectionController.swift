import UIKit



protocol RowController: UITableViewDelegate, UITableViewDataSource {
    var dispatcher: RowActionDispatching? { get set }
    func registerReusableTypes(tableView: UITableView)
}

enum RowAction {
    case selected(UUID)
}

protocol RowActionDispatching: AnyObject {
    func dispatch(_ action: RowAction)
}

final class ActionTableRowController: NSObject, RowController {
    struct Properties {
        let title: String
        let subtitle: String?
        let icon: UIImage?
        let identifier: UUID
        static let `default` = Properties(title: "Test Title", subtitle: nil, icon: UIImage(named: "pancakes"), identifier: UUID())
    }
    
    public var properties: Properties = .default
    public weak var dispatcher: RowActionDispatching?
    
    func registerReusableTypes(tableView: UITableView) {
        tableView.register(ActionIconRowCell.self, forCellReuseIdentifier: String(describing: ActionIconRowCell.self))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ActionIconRowCell.self)) as? ActionIconRowCell else {
            return UITableViewCell()
        }
        
        cell.subTitle = properties.subtitle
        cell.title = properties.title
        cell.iconImage = properties.icon
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dispatcher?.dispatch(.selected(properties.identifier))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    static func map(_ properties: Properties) -> ActionTableRowController {
        let controller = ActionTableRowController()
        controller.properties = properties
        return controller
    }
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

