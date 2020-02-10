import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var coordinator: Coordinating?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13, *) { return true }
        
        let rootCoordinator = AppCoordinator()
        coordinator = rootCoordinator
        rootCoordinator.launch(in: window)
        
        return true
    }
    
    @available(iOS 13, *)
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration",
                                    sessionRole: connectingSceneSession.role)
    }
}

@available(iOS 13, *)
final class SceneDelegate: UIResponder, UISceneDelegate {
    private var coordinator: Coordinating?
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        #if targetEnvironment(macCatalyst)
        let rootCoordinator = RootCatalystCoordinator()
        coordinator = rootCoordinator
        rootCoordinator.launch(in: window)
        #else
        let rootCoordinator = AppCoordinator()
        coordinator = rootCoordinator
        rootCoordinator.launch(in: window)
        #endif
    }
}
