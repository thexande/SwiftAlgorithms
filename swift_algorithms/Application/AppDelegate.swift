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
    
    let otherSplit = UISplitViewController()
    otherSplit.viewControllers = [UINavigationController(rootViewController: CategoryArticleListViewController()), markdown]

    split.viewControllers = [sideTable, otherSplit]

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
