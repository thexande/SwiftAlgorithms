import UIKit
import Result

enum StringNetworkServiceError: Error {
    case fail
}

final class StringNetworkService {
    func fetchMarkdown(with url: URL,
                       completion: @escaping ((Result<String, StringNetworkServiceError>) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            do {
                let contents = try String(contentsOf: url)
                completion(.success(contents))
            } catch {
                // contents could not be loaded
                completion(.failure(.fail))
            }
        }
    }
}

final class UrlFactory {
    func markdownFileUrl(for algorithmAction: AlgorithmViewController.Action) -> URL? {
        switch algorithmAction {
        case .whatAreAlgorithms:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/What%20are%20Algorithms.markdown")
        case .whyLearnAlgorithms:
            return nil
        case .bigO:
            return nil
        case .designTechniques:
            return nil
        case .howToContribute:
            return nil
            
        case .stack:
            return nil
        case .queue:
            return nil
        case .insertionSort:
            return nil
        case .binarySearch:
            return nil
        case .binarySearchTree:
            return nil
        case .mergeSort:
            return nil
        case .boyerMoore:
            return nil
            
        case .linnearSearch:
            return nil
        case .countOccurences:
            return nil
        case .selectMinMax:
            return nil
        case .kthLargestElement:
            return nil
        case .selectionSampling:
            return nil
        case .unionFind:
            return nil
        }
    }
}

final class RootTabCoordinator {
    
    private let onboardingViewController = OnboardingInformationViewController()
    private let algoController = AlgorithmViewController()
    private let dataStructureController = DataStructuresViewController()
    
    private var algorithmNav: UINavigationController?
    private var dataStructuresNav: UINavigationController?

    private let urlFactory = UrlFactory()
    private let stringNetworkService = StringNetworkService()
    private var hasPresentedOnboarding = false

    var root: UIViewController?
    
    init() {
        root = makeRootTabBarController()
        
        onboardingViewController.onDismiss = { [weak self] in
            DispatchQueue.main.async {
                self?.onboardingViewController.dismiss(animated: true, completion: nil)
            }
        }
       
    }
    
    func rootViewDidAppear() {
        if hasPresentedOnboarding == false {
            root?.present(onboardingViewController, animated: true, completion: { [weak self] in
                self?.hasPresentedOnboarding = true
            })
        }
    }
    
    private func configureOnboarding() {
        if (UserDefaults.standard.object(forKey: "has_seen_onboarding") == nil) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                if let controller = self?.onboardingViewController {
                    controller.modalTransitionStyle = .crossDissolve
                    self?.root?.present(controller, animated: true, completion: {
                        UserDefaults.standard.set(true, forKey: "has_seen_onboarding")
                    })
                }
            }
        }
    }
    
    func makeRootTabBarController() -> RootTabBarController {
        let tabBarSize = CGSize(width: 30, height: 30)
        let controller = RootTabBarController()
        
        algoController.title = "Algorithms"
        let algoImage = UIImage(named: "algo")?.scaledImage(withSize: tabBarSize)
        algoController.tabBarItem = UITabBarItem(title: "Algorithms", image: algoImage, selectedImage: algoImage)
        algoController.dispatcher = self
        let algoNav = UINavigationController(rootViewController: algoController)
        
        algorithmNav = algoNav
        
        
        let dataStructureImage = UIImage(named: "data_structure")?.scaledImage(withSize: tabBarSize)
        dataStructureController.title = "Data Structures"
        dataStructureController.tabBarItem = UITabBarItem(title: "Data Structures", image: dataStructureImage, selectedImage: dataStructureImage)
        
        let dataNav = UINavigationController(rootViewController: dataStructureController)
        
        dataStructuresNav = dataNav
        
        
        controller.viewControllers = [
            algoNav,
            dataNav
        ]
        
        controller.coordinator = self
        
        return controller
    }
    
    func makeMarkdownController(with markdown: String, title: String) -> MarkdownPresentationViewController {
        let controller = MarkdownPresentationViewController()
        controller.title = title
        controller.markdownView.load(markdown: markdown, enableImage: true)
        return controller
    }
}

extension RootTabCoordinator: RowActionDispatching {
    func dispatch(_ action: AlgorithmViewController.Action) {
        guard let url = urlFactory.markdownFileUrl(for: action) else {
            return
        }
        
        stringNetworkService.fetchMarkdown(with: url) { [weak self] result in
            switch result {
            case let .success(markdown):
            
                DispatchQueue.main.async {
                    if let controller = self?.makeMarkdownController(with: markdown, title: action.title) {
                        self?.algorithmNav?.pushViewController(controller, animated: true)
                    }
                }
                
            case .failure:
                return
            }
        }
    }
}

final class RootTabBarController: UITabBarController {
    weak var coordinator: RootTabCoordinator?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        coordinator?.rootViewDidAppear()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
