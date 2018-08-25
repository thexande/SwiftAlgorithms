import UIKit

final class RootTabCoordinator {
    
    private let onboardingViewController = OnboardingInformationViewController()

    private let algorithmViewController = AlgorithmViewController(style: .plain)
    private let algorithmPresenter = AlgorithmPresenter()
    
    private let algorithmSearchResultsController = SearchResultsTableViewController(style: .grouped)
    private let algorithmSearchResultsPresenter = AlgorithmSearchPresenter()

    private let dataStructureController = DataStructuresViewController()
    private let dataStructurePresenter = DataStructurePresenter()
    
    private var algorithmNav: UINavigationController?
    private var dataStructuresNav: UINavigationController?

    private let urlFactory = UrlFactory()
    private let stringNetworkService = StringNetworkService()
    private var hasPresentedOnboarding = false

    var root: UIViewController?
    
    init() {
        // configure dispatch
        algorithmPresenter.dispatcher = self
        algorithmViewController.dispatcher = algorithmPresenter

        // configure root views
        root = makeRootTabBarController()
        
        
        // configure onboarding
        onboardingViewController.onDismiss = { [weak self] in
            DispatchQueue.main.async {
                self?.onboardingViewController.dismiss(animated: true, completion: nil)
            }
        }
       
    }
    
    func rootViewDidAppear() {
//        if hasPresentedOnboarding == false {
//            root?.present(onboardingViewController, animated: true, completion: { [weak self] in
//                self?.hasPresentedOnboarding = true
//            })
//        }
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
        
        algorithmSearchResultsPresenter.deliver = { [weak algorithmSearchResultsController] properties in
            algorithmSearchResultsController?.properties = properties
            
        }
        
        algorithmSearchResultsPresenter.makeSearchableAlgorithmProperties()
        algorithmSearchResultsPresenter.dispatcher = self
        
        algorithmSearchResultsController.dispatcher = algorithmSearchResultsPresenter
        
        let algorithmSearchController = UISearchController(searchResultsController: algorithmSearchResultsController)
        algorithmSearchController.searchResultsUpdater = algorithmSearchResultsController
        algorithmSearchController.obscuresBackgroundDuringPresentation = true
        algorithmSearchController.searchBar.placeholder = "Search Algorithms"
        
        algorithmViewController.navigationItem.searchController = algorithmSearchController
        
        algorithmViewController.title = "Algorithms"
        let algoImage = UIImage(named: "algo")?.scaledImage(withSize: tabBarSize)
        algorithmViewController.tabBarItem = UITabBarItem(title: "Algorithms", image: algoImage, selectedImage: algoImage)

        
        // configure sections
        var controllers: [TableSectionController] = [
            algorithmPresenter.makeIntroSectionSection(),
            algorithmPresenter.makeGettingStartedSection(),
            algorithmPresenter.makeSearchingSection(),
            algorithmPresenter.makeStringSearchSection(),
            algorithmPresenter.makeCompressionSection(),
            algorithmPresenter.makeMiscellaneousSection(),
            algorithmPresenter.makeMathSection(),
            algorithmPresenter.makeMachineLearningSection(),
            algorithmPresenter.makeAboutSection()
            ]
        
        algorithmPresenter.makeSortingSections().reversed().forEach { section in
            controllers.insert(section, at: 2)
        }
        
        
        algorithmViewController.update(with: controllers)
        
        let algoNav = UINavigationController(rootViewController: algorithmViewController)
        algoNav.navigationBar.prefersLargeTitles = true
        
        algorithmNav = algoNav
        
        
        let dataStructureImage = UIImage(named: "data_structure")?.scaledImage(withSize: tabBarSize)
        dataStructureController.title = "Data Structures"
        dataStructureController.tabBarItem = UITabBarItem(title: "Data Structures", image: dataStructureImage, selectedImage: dataStructureImage)
        
        let dataStructureSectionControllers: [TableSectionController] = [
            dataStructurePresenter.makeArraySection()
        ]
        
        dataStructureController.update(with: dataStructureSectionControllers)
        
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
    
    private func handleCategorySelect(_ category: Algorithm.Category) {
        let vc = CategoryDetailViewController()
        let props = algorithmPresenter.makeGettingStartedSection()
        vc.update(with: [props])
        vc.detail.cardView.render(CategoryTileItemView.Properties(category))
        
        let nav = UINavigationController(rootViewController: vc)
        nav.hero.isEnabled = true
        algorithmNav?.present(nav, animated: true, completion: nil)
    }
    
    private func handleAlgorithmSelect(_ algorithm: Algorithm) {
        
        guard let url = urlFactory.markdownFileUrl(for: algorithm) else {
            return
        }
        
        stringNetworkService.fetchMarkdown(with: url) { [weak self] result in
            switch result {
            case let .success(markdown):
                
                DispatchQueue.main.async {
                    if let controller = self?.makeMarkdownController(with: markdown, title: algorithm.navTitle) {
                        self?.algorithmNav?.pushViewController(controller, animated: true)
                    }
                }
                
            case .failure:
                return
            }
        }
    }
}

extension RootTabCoordinator: AlgorithmPresenterActionDispatching {
    func dispatch(_ action: AlgorithmPresenter.Action) {
        switch action {
        case let .selectedAlgorithm(algorithm):
            handleAlgorithmSelect(algorithm)
        case let .selectedCategory(category):
            handleCategorySelect(category)
        }
    }
}

extension RootTabCoordinator: AlgorithmSearchPresenterDispatching {
    func dispatch(_ action: AlgorithmSearchPresenter.Action) {
        switch action {
        case let .selectedAlgorithm(algorithm):
            handleAlgorithmSelect(algorithm)
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
        tabBar.tintColor = .coral()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


