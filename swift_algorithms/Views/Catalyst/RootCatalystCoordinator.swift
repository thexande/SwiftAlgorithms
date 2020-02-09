import UIKit

final class RootCatalystCoordinator: Coordinating {
    
    let root: UIViewController?
    private let sideMenuPresenter = SideMenuPresenter()
    
    init() {
        let split = UISplitViewController()
        split.primaryBackgroundStyle = .sidebar
        
        let sideMenuView = SideMenuTableViewController()
        sideMenuPresenter.renderer = sideMenuView
        let category = CategoryArticleListViewController()
        category.delegate = sideMenuPresenter
        
        sideMenuPresenter.categoryRenderer = category
        sideMenuView.delegate = sideMenuPresenter
        
        let markdown = MarkdownPresentationViewController()
        sideMenuPresenter.markdownRenderer = markdown
        
        let otherSplit = UISplitViewController()
        otherSplit.viewControllers = [UINavigationController(rootViewController: category), markdown]

        split.viewControllers = [sideMenuView, otherSplit]
        root = split
        
        sideMenuPresenter.delegate = self
    }
    
    deinit {
        
    }
}

extension RootCatalystCoordinator: SideMenuPresenterDelegate {
    func didSelect(algorithmCatgory: AlgorithmCategory) {
        
    }
    
    func didSelect(dataStructureCategory: DataStructure.Category) {
        
    }
    
    func didSelect(puzzle: Puzzle) {
        
    }
}

