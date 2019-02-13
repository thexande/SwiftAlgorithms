import UIKit

final class ActionTableRowController: NSObject, RowController {
    
    var onSelect: ((UUID) -> Void)?
    
    struct Properties {
        let title: String
        let subtitle: String?
        let icon: UIImage?
        let identifier: UUID
        static let `default` = Properties(title: "Test Title", subtitle: nil, icon: UIImage(named: "pancakes"), identifier: UUID())
    }
    
    public var properties: Properties = .default
    
    func registerReusableTypes(tableView: UITableView) {
        tableView.register(ActionIconRowCell.self, forCellReuseIdentifier: String(describing: ActionIconRowCell.self))
    }
    
    static func map(_ properties: Properties) -> ActionTableRowController {
        let controller = ActionTableRowController()
        controller.properties = properties
        return controller
    }
}

extension ActionTableRowController: UITableViewDelegate, UITableViewDataSource {
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
        onSelect?(properties.identifier)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
