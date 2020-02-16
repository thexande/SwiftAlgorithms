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
    let searchPresenter = CatalystAlgorithmSearchPresenter()

    
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
    
    func presentSearch() {
        root?.present(makeSearchView(), animated: true)
    }
    
    private func makeSearchView() -> UIViewController {
        let view = CatalystSearchResultsTableViewController(style: .grouped)
        searchPresenter.makeSearchableAlgorithmProperties()
        view.delegate = searchPresenter
        searchPresenter.renderer = view
        searchPresenter.delegate = self
        return UINavigationController(rootViewController: view)
    }
}

@available(iOS 13.0, *)
extension RootCatalystCoordinator: CatalystAlgorithmSearchPresenterDispatching {
    func didSelect(algorithm: Algorithm) {
        let markdown = MarkdownPresentationViewController()
        markdown.setMarkdown(for: algorithm)
        mainMenuSplitView.showDetailViewController(markdown, sender: nil)
    }
    
    func didSelect(dataStructure: DataStructure) {
        let markdown = MarkdownPresentationViewController()
        markdown.setMarkdown(for: dataStructure)
        mainMenuSplitView.showDetailViewController(markdown, sender: nil)
    }
    
    func didSelect(puzzle: Puzzle) {
        let markdown = MarkdownPresentationViewController()
        markdown.setMarkdown(for: puzzle)
        mainMenuSplitView.showDetailViewController(markdown, sender: nil)
    }
}

