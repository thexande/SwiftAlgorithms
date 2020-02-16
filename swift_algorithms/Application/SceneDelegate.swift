import UIKit

@available(macCatalyst 10.15, *)
protocol AppToolBarDelegate: AnyObject {
    func didPressSearchButton()
}

@available(macCatalyst 10.15, iOS 13, *)
final class SceneDelegate: UIResponder, UISceneDelegate {
    private var coordinator: Coordinating?
    var window: UIWindow?
    private weak var toolBarDelegate: AppToolBarDelegate?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        #if targetEnvironment(macCatalyst)
        windowScene.titlebar?.toolbar = makeTool()
        windowScene.titlebar?.titleVisibility = .hidden
        
        let rootCoordinator = RootCatalystCoordinator()
        toolBarDelegate = rootCoordinator
        coordinator = rootCoordinator
        rootCoordinator.launch(in: window)
        #else
        let rootCoordinator = AppCoordinator()
        coordinator = rootCoordinator
        rootCoordinator.launch(in: window)
        #endif
    }
    
    @objc private func searchButtonPressed(sender: UIBarButtonItem) {
        toolBarDelegate?.didPressSearchButton()
    }
}

#if targetEnvironment(macCatalyst)
fileprivate extension SceneDelegate {
    private func makeTool() -> NSToolbar {
        let toolbar = NSToolbar(identifier: "MyToolbar")
        toolbar.displayMode = .iconOnly
        toolbar.delegate = self
        return toolbar
    }
}

// MARK: - MainCatalystPresenterDelegate

@available(macCatalyst 10.15, *)
extension SceneDelegate: NSToolbarDelegate {
    func toolbar(_ toolbar: NSToolbar,
                 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        if itemIdentifier == .init("search") {
            let barButton = UIBarButtonItem(barButtonSystemItem: .search,
                                            target: self,
                                            action: #selector(searchButtonPressed(sender:)))
            let button = NSToolbarItem(itemIdentifier: itemIdentifier,
                                       barButtonItem: barButton)
            button.title = "Search                       "
            return button
        }
        else if itemIdentifier == .init("title") {
            let title = UIBarButtonItem(title: "Algorithms And Data Structures",
                                        style: .plain,
                                        target: nil,
                                        action: nil)
            let button = NSToolbarItem(itemIdentifier: .init("title"),
                                       barButtonItem: title)
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
        [
            .init("show_sidebar"),
            NSToolbarItem.Identifier.flexibleSpace,
            .init("title"),
            NSToolbarItem.Identifier.flexibleSpace,
            .init("search")
        ]
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        toolbarDefaultItemIdentifiers(toolbar)
    }
}
#endif
