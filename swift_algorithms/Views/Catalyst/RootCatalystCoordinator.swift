import UIKit

final class MainCatalystViewController: UISplitViewController {
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
        if hasPresentedOnboarding == false {
            present(onboarding, animated: true, completion: { [weak self] in
                self?.hasPresentedOnboarding = true
            })
        }
        
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
    private let sideMenuPresenter = SideMenuPresenter()
    
    init() {
        let split = MainCatalystViewController()
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
    }
    
    deinit {
        
    }
}

