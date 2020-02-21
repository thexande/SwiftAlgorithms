import UIKit
import Anchorage
import SwiftAlgorithmsUserInterface
import SwiftAlgorithmsDataLayer

@available(macCatalyst 10.15, iOS 13, *)
final class RootCatalystCoordinator: Coordinating {
    let root: UIViewController?
    private let sideMenuPresenter = MainCatalystPresenter()
    private let categoryDisplaySplitView = UISplitViewController()
    private let mainMenuSplitView = MainCatalystSplitViewController()
    private let sideMenuView = SideMenuTableViewController()
    private let categoryNavigationView = UINavigationController()
    private let about = AboutViewController()
    private let searchPresenter = CatalystSearchResultsPresenter()

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

// MARK: - MainCatalystPresenterDelegate

@available(macCatalyst 10.15, iOS 13, *)
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
        let view = CatalystSearchResultsTableViewController()
        view.delegate = searchPresenter
        searchPresenter.renderer = view
        searchPresenter.delegate = self
        return UINavigationController(rootViewController: view)
    }
}

// MARK: - CatalystAlgorithmSearchPresenterDispatching

@available(macCatalyst 10.15, iOS 13, *)
extension RootCatalystCoordinator: CatalystSearchPresenterDispatching {
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

// MARK: - AppToolBarDelegate

@available(macCatalyst 10.15, iOS 13, *)
extension RootCatalystCoordinator: AppToolBarDelegate {
    func didPressSearchButton() {
        root?.present(makeSearchView(), animated: true)
        
        if (UserDefaults.standard.object(forKey: "has_seen_search_hint") == nil) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                UserDefaults.standard.set(true, forKey: "has_seen_search_hint")
                let alert = UIAlertController(title: "👋 Quick Tip",
                                              message: "Looking for something? Skip the tool bar button and just press the space key next time!",
                                              preferredStyle: .alert)
                
                alert.addAction(.init(title: "OK", style: .default, handler: nil))
                self?.root?.present(alert, animated: true)
            }
        }
    }
}
