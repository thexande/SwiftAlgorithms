import UIKit

final class AlgorithmViewController: SectionProxyTableViewController {
    let header = QuadrantSelectorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.tableHeaderView = header
        
        let items = [
            QuadrantItemView.Properties(title: "Search", image: UIImage(), backgroundColor: .turquiose()),
            QuadrantItemView.Properties(title: "Compress", image: UIImage(), backgroundColor: .flatRed()),
            QuadrantItemView.Properties(title: "Sort", image: UIImage(), backgroundColor: .amethist()),
            QuadrantItemView.Properties(title: "Math", image: UIImage(), backgroundColor: .orangeCream()),
            ]
        
        header.configure(with: items)
    }
}

final class DataStructuresViewController: SectionProxyTableViewController {
    let header = QuadrantSelectorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.tableHeaderView = header
        
        let items = [
            QuadrantItemView.Properties(title: "Trees", image: UIImage(), backgroundColor: .turquiose()),
            QuadrantItemView.Properties(title: "Compress", image: UIImage(), backgroundColor: .flatRed()),
            QuadrantItemView.Properties(title: "Sort", image: UIImage(), backgroundColor: .amethist()),
            QuadrantItemView.Properties(title: "Math", image: UIImage(), backgroundColor: .orangeCream()),
            ]
        
        header.configure(with: items)
    }
}

final class RootTabCoordinator {
    var root: UIViewController?
    
    init() {
        root = makeRootTabBarController()
    }
    
    func makeRootTabBarController() -> RootTabBarController {
        let controller = RootTabBarController()
        
        let algoController = AlgorithmViewController()
        algoController.title = "Algorithms"
        
        let algoNav = UINavigationController(rootViewController: algoController)
        
        
        let dataStructureController = DataStructuresViewController()
        dataStructureController.title = "Data Structures"
        
        let dataNav = UINavigationController(rootViewController: dataStructureController)
        
        
        controller.viewControllers = [
            algoNav,
            dataNav
        ]
        
        return controller
    }
    
    
}

final class RootTabBarController: UITabBarController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
