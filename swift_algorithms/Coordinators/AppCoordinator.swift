import UIKit
import SwiftAlgorithmsUserInterface

final class AppCoordinator: Coordinating {

    let root: UIViewController?
    var tabCoordinator: RootTabCoordinator?
    
    init() {
        let coordinator = RootTabCoordinator()
        tabCoordinator = coordinator
        root = coordinator.root
        setAppearance()
    }
    
    private func setAppearance() {
        UINavigationBar.appearance().tintColor = .coral()
        UITabBar.appearance().tintColor = .coral()
        UITextField.appearance().tintColor = .coral()
        UISearchBar.appearance().tintColor = .coral()
        
    }
}
