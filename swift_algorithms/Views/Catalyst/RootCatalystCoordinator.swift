import UIKit

@available(iOS 13.0, *)
final class RootCatalystCoordinator: Coordinating {
    
    let root: UIViewController?
    private let sideMenuPresenter = MainCatalystPresenter()
    private let categoryDisplaySplitView = UISplitViewController()
    private let mainMenuSplitView = MainCatalystSplitViewController()
    private let sideMenuView = SideMenuTableViewController()

    
    init() {
        mainMenuSplitView.primaryBackgroundStyle = .sidebar
        
        sideMenuView.delegate = sideMenuPresenter
        sideMenuPresenter.renderer = sideMenuView
        
        let category = CategoryArticleListViewController()
        category.delegate = sideMenuPresenter
        sideMenuPresenter.categoryRenderer = category
        
        let markdown = MarkdownPresentationViewController()
        sideMenuPresenter.markdownRenderer = markdown
        
        categoryDisplaySplitView.viewControllers = [UINavigationController(rootViewController: category), markdown]
                
        mainMenuSplitView.viewControllers = [sideMenuView, AboutViewController()]
        root = mainMenuSplitView
        
        sideMenuPresenter.delegate = self
    }
}

extension RootCatalystCoordinator: MainCatalystPresenterDelegate {
    func showCategorySelectorView() {
        mainMenuSplitView.viewControllers = [sideMenuView, categoryDisplaySplitView]
    }
    
    func showAboutView() {
        mainMenuSplitView.viewControllers = [sideMenuView, AboutViewController()]
    }
}

