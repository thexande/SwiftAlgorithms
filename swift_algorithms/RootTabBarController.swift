import UIKit

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
