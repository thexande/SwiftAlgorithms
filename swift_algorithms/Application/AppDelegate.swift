import UIKit

protocol AppCoordinatorActionsDispatching: AnyObject {
    func userDidShake()
}

final class Themer {
    static let shared = Themer()
    // default theme
    var currentTheme: Theme = .light
}

final class AppCoordinator {
    
    private var rootTabCoordinator: RootTabCoordinator? {
        didSet {
            root = rootTabCoordinator?.root
        }
    }
    
    var root: UIViewController? {
        didSet {
            if
                let app = UIApplication.shared.delegate as? AppDelegate,
                let window = app.window,
                let root = root {
                    window.switchRootViewController(root)
            }
        }
    }
    
    // default theme
    private var currentTheme: Theme = .light {
        didSet {
            setAppearance(with: currentTheme)
            Themer.shared.currentTheme = currentTheme
            rootTabCoordinator = RootTabCoordinator(theme: currentTheme)
            rootTabCoordinator?.appCoordinatorDispatch = self
        }
    }
    
    func rootViewController() -> UIViewController? {
        let coordinator = RootTabCoordinator(theme: currentTheme)
        
        // configure with default theme
        setAppearance(with: currentTheme)
        Themer.shared.currentTheme = currentTheme
        
        coordinator.appCoordinatorDispatch = self
        rootTabCoordinator = coordinator
        root = coordinator.root
        return root
    }
    
    private func setAppearance(with theme: Theme) {
        
        let tint: UIColor
        let background: UIColor
        let style: UIBarStyle
        
        switch theme {
        case .dark:
            tint = .coral()
            background = .darkModeOne()
            style = .black
            UITextField.appearance().keyboardAppearance = .dark
        case .light:
            tint = .appleBlue()
            background = .white
            style = .default
            UITextField.appearance().keyboardAppearance = .light
        }
        
        UINavigationBar.appearance().tintColor = tint
        UINavigationBar.appearance().barStyle = style
        
        UITabBar.appearance().barStyle = style
        UITabBar.appearance().tintColor = tint
        
        UITextField.appearance().tintColor = tint
        UISearchBar.appearance().tintColor = tint
        
        UITableViewCell.appearance().backgroundColor = background
    }
}

extension AppCoordinator: AppCoordinatorActionsDispatching {
    func userDidShake() {
        switch currentTheme {
        case .dark:
            currentTheme = .light
        case .light:
            currentTheme = .dark
        }
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
