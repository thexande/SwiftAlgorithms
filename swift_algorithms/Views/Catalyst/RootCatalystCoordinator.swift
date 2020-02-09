import UIKit

final class MainCatalystSplitViewController: UISplitViewController {
    let onboarding = OnboardingInformationViewController()
    private var hasPresentedOnboarding = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onboarding.onDismiss = { [weak self] in
            self?.onboarding.dismiss(animated: true, completion: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.present(self.onboarding, animated: true, completion: nil)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // enable for non UserDefaults driven onboarding presentation
//        if hasPresentedOnboarding == false {
//            present(onboarding, animated: true, completion: { [weak self] in
//                self?.hasPresentedOnboarding = true
//            })
//        }
        
        //                 UserDefaults driven onboarding presentation
        //                configureOnboarding()
    }
    
    private func configureOnboarding() {
        if (UserDefaults.standard.object(forKey: "has_seen_onboarding") == nil) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                if let controller = self?.onboarding {
                    controller.modalTransitionStyle = .crossDissolve
                    self?.present(controller, animated: true, completion: {
                        UserDefaults.standard.set(true, forKey: "has_seen_onboarding")
                    })
                }
            }
        }
    }
}

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

