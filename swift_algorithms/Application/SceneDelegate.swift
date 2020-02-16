import UIKit

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
        windowScene.titlebar?.toolbar = makeTool()
        
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
        let view = UINavigationController(rootViewController: CatalystSearchResultsTableViewController(style: .plain))
        UIApplication.shared.windows.first?.rootViewController?.present(view, animated: true, completion: nil)
    }
}

#if targetEnvironment(macCatalyst)
fileprivate extension SceneDelegate {
    private func makeTool() -> NSToolbar {
        let toolbar = NSToolbar(identifier: "MyToolbar")
        toolbar.delegate = self
        return toolbar
    }
}

extension SceneDelegate: NSToolbarDelegate {
    func toolbar(_ toolbar: NSToolbar,
                 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        if itemIdentifier == .init("search") {
            let barButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonPressed(sender:)))
            let button = NSToolbarItem(itemIdentifier: itemIdentifier, barButtonItem: barButton)
            button.title = "Search         "
            return button
        }
//        else if itemIdentifier == .init("show_sidebar") {
//            let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(myFancyAction(sender:)))
//            let button = NSToolbarItem(itemIdentifier: itemIdentifier, barButtonItem: barButton)
//            return button
//            return nil
//        }
    else {
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
