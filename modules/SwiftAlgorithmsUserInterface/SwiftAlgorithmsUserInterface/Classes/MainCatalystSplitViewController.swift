import UIKit

public final class MainCatalystSplitViewController: UISplitViewController {
    let onboarding = OnboardingInformationViewController()
    private var hasPresentedOnboarding = false
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        onboarding.onDismiss = { [weak self] in
            self?.onboarding.dismiss(animated: true, completion: nil)
        }
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // enable for non UserDefaults driven onboarding presentation
//        if hasPresentedOnboarding == false {
//            present(onboarding, animated: true, completion: { [weak self] in
//                self?.hasPresentedOnboarding = true
//            })
//        }
        
        // UserDefaults driven onboarding presentation
        configureOnboarding()
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
