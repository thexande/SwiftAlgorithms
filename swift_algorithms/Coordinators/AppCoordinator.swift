import UIKit

final class AppCoordinator {
    
    private var rootTabCoordinator: RootTabCoordinator?
    
    var root: UIViewController?
    
    func rootViewController() -> UIViewController? {
        let coordinator = RootTabCoordinator()
        rootTabCoordinator = coordinator
        root = coordinator.root
        return root
    }
    
    init() {
        setAppearance()
    }
    
    private func setAppearance() {
        UINavigationBar.appearance().tintColor = .coral()
        UITabBar.appearance().tintColor = .coral()
        UITextField.appearance().tintColor = .coral()
        UISearchBar.appearance().tintColor = .coral()
        
    }
}
