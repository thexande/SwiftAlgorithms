import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let coordinator = RootTabCoordinator()

 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinator.root
        window?.makeKeyAndVisible()
    
    UINavigationBar.appearance().tintColor = UIColor.coral()
//    UINavigationBar.appearance().isTranslucent = false
//    UINavigationBar.appearance().backgroundColor = .black
    UINavigationBar.appearance().barStyle = UIBarStyle.black //user global variable
    
    
    UITabBar.appearance().barStyle = .black
    UITabBar.appearance().tintColor = .coral()
    
    UITableView.appearance().backgroundColor = .darkModeTableBackground()
    
    UITextField.appearance().keyboardAppearance = .dark
    UITextField.appearance().tintColor = .coral()
    UISearchBar.appearance().tintColor = .coral()
    
    
    UITableViewCell.appearance().backgroundColor = .black
//    UITableViewCell.appearance().color
    //UINavigationBar.appearance().tintColor =

    
        return true
    }
}
