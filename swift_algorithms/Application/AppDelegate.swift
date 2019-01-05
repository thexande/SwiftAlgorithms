import UIKit

protocol AppCoordinatorActionsDispatching: AnyObject {
    func userDidShake()
}

final class Themer {
    static let shared = Themer()
    var currentTheme: Theme = .dark
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
    
    private var currentTheme: Theme = .dark {
        didSet {
            setAppearance(with: currentTheme)
            Themer.shared.currentTheme = currentTheme
            rootTabCoordinator = RootTabCoordinator(theme: currentTheme)
            rootTabCoordinator?.appCoordinatorDispatch = self
        }
    }
    
    init() {

    }
    
    func rootViewController() -> UIViewController? {
        let coordinator = RootTabCoordinator(theme: currentTheme)
        setAppearance(with: currentTheme)
        coordinator.appCoordinatorDispatch = self
        rootTabCoordinator = coordinator
        root = coordinator.root
        return root
    }
    
    private func setAppearance(with theme: Theme) {
        
        let tint: UIColor
        let background: UIColor
        let style: UIBarStyle
        let tableBackground: UIColor
        
        switch theme {
        case .dark:
            tint = .coral()
            background = .black
            style = .black
            tableBackground = .darkModeTableBackground()
            UITextField.appearance().keyboardAppearance = .dark
        case .light:
            tint = .appleBlue()
            background = .white
            style = .default
            tableBackground = .white
            UITextField.appearance().keyboardAppearance = .light
        }
        
        
        UINavigationBar.appearance().tintColor = tint
        UINavigationBar.appearance().barStyle = style
        
        
        UITabBar.appearance().barStyle = style
        UITabBar.appearance().tintColor = tint
        
//        UITableView.appearance().backgroundColor = tableBackground
        
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
                                  options: UIView.AnimationOptions = .transitionFlipFromRight,
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
