import UIKit

@available(iOS 13.0, *)
protocol SideMenuViewDelegate: AnyObject {
    func didSelectItem(with identifier: UUID)
    func viewDidLoad()
}

@available(iOS 13.0, *)
protocol SideMenuTableViewRendering: AnyObject {
    var properties: SideMenuTableViewController.Properties { get set }
}

@available(iOS 13.0, *)
final class SideMenuTableViewController: UITableViewController, SideMenuTableViewRendering {
    
    struct Properties {
        let sections: [Section]
        struct Section {
            let items: [SideMenuItemCell.Properties]
            let title: String
        }
        static let `default` = Properties(sections: [])
    }
    
    var properties = Properties.default {
        didSet {
            tableView.reloadData()
        }
    }
    
    weak var delegate: SideMenuViewDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SideMenuItemCell.self, forCellReuseIdentifier: SideMenuItemCell.reuseIdentifier)
        delegate?.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return properties.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return properties.sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.sections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuItemCell.reuseIdentifier) as? SideMenuItemCell else {
            return UITableViewCell()
        }

        cell.properties = properties.sections[indexPath.section].items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(with: properties.sections[indexPath.section].items[indexPath.item].identifier)
    }
}

