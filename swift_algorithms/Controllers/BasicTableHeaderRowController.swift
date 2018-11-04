import UIKit

final class BasicTableHeaderRowController: NSObject, RowController {
    
    var onSelect: ((UUID) -> Void)?
    
    struct Properties {
        let title: String
        static let `default` = Properties(title: "title")
    }
    
    public var properties: Properties = .default
    
    func registerReusableTypes(tableView: UITableView) {
        tableView.register(BasicTableHeaderCell.self, forCellReuseIdentifier: String(describing: BasicTableHeaderCell.self))
    }
    
    static func map(_ properties: Properties) -> BasicTableHeaderRowController {
        let controller = BasicTableHeaderRowController()
        controller.properties = properties
        return controller
    }
}

extension BasicTableHeaderRowController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasicTableHeaderCell.self))
        cell?.textLabel?.text = properties.title
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
