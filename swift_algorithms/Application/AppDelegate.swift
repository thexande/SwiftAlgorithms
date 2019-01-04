import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let coordinator = RootTabCoordinator()

 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinator.root
        window?.makeKeyAndVisible()
    
    UINavigationBar.appearance().isTranslucent = false
    UINavigationBar.appearance().backgroundColor = .black
    UINavigationBar.appearance().barStyle = UIBarStyle.black //user global variable
    UINavigationBar.appearance().tintColor = UIColor.black //user global variable
    
    UITableViewCell.appearance().backgroundColor = .black
//    UITableViewCell.appearance().color
    //UINavigationBar.appearance().tintColor =

    
        return true
    }
}
