import UIKit

final class Themer {
    static let shared = Themer()
    var currentTheme: Theme = .dark
}

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

extension UIWindow {
    
    func switchRootViewController(_ viewController: UIViewController,
                                  animated: Bool = true,
                                  duration: TimeInterval = 0.5,
                                  options: UIView.AnimationOptions = .transitionFlipFromBottom,
                                  completion: (() -> Void)? = nil) {
        guard animated else {
            rootViewController = viewController
            return
        }
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }) { _ in
            completion?()
        }
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let coordinator = AppCoordinator()

 func application(_ application: UIApplication,
                  didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinator.rootViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
