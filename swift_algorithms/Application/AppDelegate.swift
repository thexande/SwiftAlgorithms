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
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        #if targetEnvironment(macCatalyst)
        if let titlebar = windowScene.titlebar {
            titlebar.titleVisibility = .hidden
            titlebar.toolbar = makeToolbar()
        }
        
        let rootCoordinator = RootCatalystCoordinator()
        coordinator = rootCoordinator
        rootCoordinator.launch(in: window)
        #else
        let rootCoordinator = AppCoordinator()
        coordinator = rootCoordinator
        rootCoordinator.launch(in: window)
        #endif
    }
    
    @objc private func searchButtonPressed(sender: UIBarButtonItem) {
        print("Button Pressed")
    }
    
    private func makeToolbar() -> NSToolbar {
        let toolbar = NSToolbar(identifier: "MyToolbar")
        toolbar.delegate = self
        return toolbar
    }
}

#if targetEnvironment(macCatalyst)
extension SceneDelegate: NSToolbarDelegate {
    func toolbar(_ toolbar: NSToolbar,
                 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        if itemIdentifier == .init("search") {
            let barButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonPressed(sender:)))
            let button = NSToolbarItem(itemIdentifier: itemIdentifier, barButtonItem: barButton)
            button.title = "Search         "
            return button
        } else if itemIdentifier == .init("show_sidebar") {
//            let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(myFancyAction(sender:)))
//            let button = NSToolbarItem(itemIdentifier: itemIdentifier, barButtonItem: barButton)
//            return button
            return nil
        } else {
            return nil
        }
    }

    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [.init("show_sidebar"), NSToolbarItem.Identifier.flexibleSpace, .init("search")]
    }

    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarDefaultItemIdentifiers(toolbar)
    }
}
#endif
