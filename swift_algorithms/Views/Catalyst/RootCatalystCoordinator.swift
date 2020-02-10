import UIKit
import Anchorage
import SwiftAlgorithmsUserInterface

@available(iOS 13.0, *)
final class RootCatalystCoordinator: Coordinating {
    
    let root: UIViewController?
    private let sideMenuPresenter = MainCatalystPresenter()
    private let categoryDisplaySplitView = UISplitViewController()
    private let mainMenuSplitView = MainCatalystSplitViewController()
    private let sideMenuView = SideMenuTableViewController()
    private let categoryNavigationView = UINavigationController()
    private let about = AboutViewController()
    
    init() {
        mainMenuSplitView.primaryBackgroundStyle = .sidebar
        
        sideMenuView.delegate = sideMenuPresenter
        sideMenuPresenter.renderer = sideMenuView
        
        let category = CategoryArticleListViewController()
        category.delegate = sideMenuPresenter
        sideMenuPresenter.categoryRenderer = category
        categoryNavigationView.setViewControllers([category], animated: false)
        
        let markdown = MarkdownPresentationViewController()
        sideMenuPresenter.markdownRenderer = markdown
        
                
        mainMenuSplitView.viewControllers = [sideMenuView, AboutViewController()]
        root = mainMenuSplitView
        
        sideMenuPresenter.delegate = self
    
        let view = UINavigationController(rootViewController: CatalystSearchViewController())
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.root?.present(view, animated: false, completion: nil)
//        }
    }
}

@available(iOS 13.0, *)
extension RootCatalystCoordinator: MainCatalystPresenterDelegate {
    func show(puzzle: Puzzle) {
        let markdown = MarkdownPresentationViewController()
        markdown.setMarkdown(for: puzzle)
        mainMenuSplitView.showDetailViewController(markdown, sender: nil)
    }
    
    func showCategorySelectorViewWithAbout() {
        mainMenuSplitView.showDetailViewController(categoryDisplaySplitView, sender: nil)
        categoryDisplaySplitView.viewControllers = [categoryNavigationView, about]
    }
    
    func showCategorySelectorViewWithMarkdown() {
        mainMenuSplitView.showDetailViewController(categoryDisplaySplitView, sender: nil)
        let markdown = MarkdownPresentationViewController()
        sideMenuPresenter.markdownRenderer = markdown
        
        categoryDisplaySplitView.viewControllers = [categoryNavigationView, markdown]
    }
    
    func showAboutView() {
        mainMenuSplitView.showDetailViewController(about, sender: nil)
    }
}

