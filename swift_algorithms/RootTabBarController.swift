import UIKit

final class RootTabCoordinator {
    let tabBarSize = CGSize(width: 30, height: 30)
    
    var root: UIViewController?
    
    init() {
        root = makeRootTabBarController()
    }
    
    func makeRootTabBarController() -> RootTabBarController {
        let controller = RootTabBarController()
        
        let algoController = AlgorithmViewController()
        algoController.title = "Algorithms"
        let algoImage = UIImage(named: "algo")?.scaledImage(withSize: tabBarSize)
        algoController.tabBarItem = UITabBarItem(title: "Algorithms", image: algoImage, selectedImage: algoImage)
        
        let algoNav = UINavigationController(rootViewController: algoController)
        
        
        let dataStructureImage = UIImage(named: "data_structure")?.scaledImage(withSize: tabBarSize)
        let dataStructureController = DataStructuresViewController()
        dataStructureController.title = "Data Structures"
        dataStructureController.tabBarItem = UITabBarItem(title: "Data Structures", image: dataStructureImage, selectedImage: dataStructureImage)
        
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
