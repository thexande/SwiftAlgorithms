import UIKit


final class SideMenuTableViewController: UITableViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SideMenuItemCell.self, forCellReuseIdentifier: SideMenuItemCell.reuseIdentifier)
        
        
        
        let category = AlgorithmCategory.allCases.map {
            SideMenuItemCell.Properties(background: $0.color, icon: $0.image, name: $0.title)
        }
        
        let ds = DataStructure.Category.allCases.map {
            SideMenuItemCell.Properties(background: $0.color, icon: $0.image, name: $0.title)
        }
        
        properties = .init(sections: [
            .init(items: category, title: "Algorithms"),
            .init(items: ds, title: "Data Structures")
        ])
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
}

