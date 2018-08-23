import UIKit

final class BasicTableRowController: NSObject, RowController {
    
    public struct Properties {
        let title: String
        let subtitle: String?
        let showsDisclosure: Bool
        let identifier: UUID
        static let `default` = Properties(title: "title", subtitle: nil, showsDisclosure: false, identifier: UUID())
    }
    
    public var properties: Properties = .default
    
    var onSelect: ((UUID) -> Void)?

    
    func registerReusableTypes(tableView: UITableView) {
        tableView.register(BasicTableCell.self, forCellReuseIdentifier: String(describing: BasicTableCell.self))
    }
    
    static func map(_ properties: Properties) -> BasicTableRowController {
        let controller = BasicTableRowController()
        controller.properties = properties
        return controller
    }
}

extension BasicTableRowController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasicTableCell.self))
        cell?.textLabel?.text = properties.title
        cell?.detailTextLabel?.text = properties.subtitle
        
        if properties.showsDisclosure {
            cell?.accessoryType = .disclosureIndicator
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelect?(properties.identifier)
    }
}
