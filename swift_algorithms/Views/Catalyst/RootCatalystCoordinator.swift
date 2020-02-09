import UIKit

final class RootCatalystCoordinator: Coordinating {
    
    let root: UIViewController?
    
    init() {
        let split = UISplitViewController()
        split.primaryBackgroundStyle = .sidebar
        
        let sideTable = SideMenuTableViewController()
        let markdown = MarkdownPresentationViewController()
        
        let otherSplit = UISplitViewController()
        otherSplit.viewControllers = [UINavigationController(rootViewController: CategoryArticleListViewController()), markdown]

        split.viewControllers = [sideTable, otherSplit]
        root = split
    }
}

