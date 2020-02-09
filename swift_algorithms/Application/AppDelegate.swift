import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var coordinator: Coordinating?

 func application(_ application: UIApplication,
                  didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    
    #if targetEnvironment(macCatalyst)
    let rootCoordinator = RootCatalystCoordinator()
    coordinator = rootCoordinator
    rootCoordinator.launch(in: window)
    
    #else
    let rootCoordinator = AppCoordinator()
    coordinator = rootCoordinator
    rootCoordinator.launch(in: window)
    #endif
    
        return true
    }
}
