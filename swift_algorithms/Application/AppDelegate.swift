import UIKit
import Anchorage

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let coordinator = AppCoordinator()

 func application(_ application: UIApplication,
                  didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    #if targetEnvironment(macCatalyst)
        print("UIKit running on macOS")

    window = UIWindow(frame: UIScreen.main.bounds)
    let split = UISplitViewController()
    split.primaryBackgroundStyle = .sidebar
    
    let sideTable = SideMenuTableViewController()
    let markdown = MarkdownPresentationViewController()

    split.viewControllers = [sideTable, markdown]
    window?.rootViewController = split
    window?.makeKeyAndVisible()


    
    #else
        print("Your regular code")

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = coordinator.rootViewController()
    window?.makeKeyAndVisible()
    #endif
    
        return true
    }
}

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
        
//        navigationItem.searchController = UISearchController()
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

final class SideMenuItemCell: UITableViewCell, Reusable {
    
    struct Properties {
        let background: UIColor
        let icon: UIImage?
        let name: String
        static let `default` = Properties(background: .green, icon: nil, name: "")
    }
    
    private let icon = UIImageView()
    private let card = UIView()
    
    var properties = Properties.default {
        didSet {
            textLabel?.text = "          \(properties.name)"
            icon.image = properties.icon?.withRenderingMode(.alwaysTemplate)
            card.backgroundColor = properties.background
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(card)
        card.sizeAnchors == CGSize(width: 36, height: 36)
        card.leadingAnchor == safeAreaLayoutGuide.leadingAnchor + 12
        card.centerYAnchor == centerYAnchor
        card.layer.cornerRadius = 6
        
        card.addSubview(icon)
        let inset: CGFloat = 6
        icon.edgeAnchors == card.edgeAnchors + UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
