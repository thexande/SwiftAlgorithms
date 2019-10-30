import UIKit
import Anchorage

enum Theme {
    case light
    case dark
}

final class GlobalSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
}

final class RootTabCoordinator {
    private let onboardingViewController = OnboardingInformationViewController()
    
    private let algorithmViewController = AlgorithmViewController(style: .plain)
    private let algorithmPresenter = AlgorithmPresenter()
    private let algorithmMarkdownViewController = MarkdownPresentationViewController()
    
    private let algorithmSearchResultsController = SearchResultsTableViewController(style: .grouped)
    private let algorithmSearchResultsPresenter = AlgorithmSearchPresenter()
    
    private let dataStructureController = DataStructuresViewController(style: .grouped)
    private let dataStructurePresenter = DataStructurePresenter()
    
    private let dataStructureSearchResultsController = SearchResultsTableViewController(style: .grouped)
    private let dataStructureSearchResultsPresenter = DataStructureSearchPresenter()
    
    private let puzzlesViewController = PuzzlesViewController(style: .grouped)
    private let puzzlesPresenter = PuzzlesPresenter()
    private var puzzleNavigation: UINavigationController?
    
    private let aboutViewController = AboutViewController()
    
    private var algorithmNav: UIViewController?
    private var dataStructuresNav: UIViewController?
    
    private let urlFactory = UrlFactory()
    private let stringNetworkService = StringNetworkService()
    private var hasPresentedOnboarding = false
    
    private var categoryCoordinator: CategoryCoordinator?
    
    var root: UIViewController?
    
    
    init() {
        // configure dispatch
        algorithmPresenter.dispatcher = self
        algorithmViewController.dispatcher = algorithmPresenter
        
        dataStructurePresenter.dispatcher = self
        dataStructureController.dispatcher = dataStructurePresenter
        
        puzzlesPresenter.dispatcher = self
        puzzlesViewController.dispatcher = puzzlesPresenter
        
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
        
        // enable for non UserDefaults driven onboarding presentation
//        if hasPresentedOnboarding == false {
//            root?.present(onboardingViewController, animated: true, completion: { [weak self] in
//                self?.hasPresentedOnboarding = true
//            })
//        }
        
        // UserDefaults driven onboarding presentation
        configureOnboarding()
        
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
    
    private func makeAlgorithmViewController() -> UIViewController {
        let tabBarSize = CGSize(width: 30, height: 30)
        
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
        
        
        // configure sections
        let controllers: [TableSectionController] = algorithmPresenter.makeAllAlgorithmSections()
            
        
        algorithmViewController.update(with: controllers)
        
        let algoNav = UINavigationController(rootViewController: algorithmViewController)
        algoNav.navigationBar.prefersLargeTitles = true
        
        
        let about = AboutViewController()

        let split = GlobalSplitViewController()
        split.viewControllers = [algoNav, UINavigationController(rootViewController: about)]
        
        about.navigationItem.leftBarButtonItem = split.displayModeButtonItem
        about.navigationItem.leftItemsSupplementBackButton = true
        
        
        let algoImage = UIImage(named: "algo")?.scaledImage(withSize: tabBarSize)
        split.tabBarItem = UITabBarItem(title: "Algorithms",
                                        image: algoImage,
                                        selectedImage: algoImage)
        
        return split
    }
    
    private func makeDataStructureViewController() -> UIViewController {
        let tabBarSize = CGSize(width: 30, height: 30)
        
        dataStructureSearchResultsPresenter.deliver = { [weak dataStructureSearchResultsController] properties in
            dataStructureSearchResultsController?.properties = properties
        }
        
        dataStructureSearchResultsPresenter.makeSearchableDataStructureProperties()
        dataStructureSearchResultsPresenter.dispatcher = self
        
        dataStructureSearchResultsController.dispatcher = dataStructureSearchResultsPresenter
        
        let dataStructureSearchController = UISearchController(searchResultsController: dataStructureSearchResultsController)
        dataStructureSearchController.searchResultsUpdater = dataStructureSearchResultsController
        dataStructureSearchController.obscuresBackgroundDuringPresentation = true
        dataStructureSearchController.searchBar.placeholder = "Search Data Structures"
        
        dataStructureController.navigationItem.searchController = dataStructureSearchController
        
        let dataStructureImage = UIImage(named: "data_structure")?.scaledImage(withSize: tabBarSize)
        dataStructureController.title = "Data Structures"
        
        
        
        let dataStructureSectionControllers = dataStructurePresenter.makeAllSectiions()
        
        dataStructureController.update(with: dataStructureSectionControllers)
        
        let dataNav = UINavigationController(rootViewController: dataStructureController)
        dataNav.navigationBar.prefersLargeTitles = true
        
        let about = AboutViewController()
        let split = GlobalSplitViewController()
        split.tabBarItem = UITabBarItem(title: "Data Structures",
                                        image: dataStructureImage,
                                        selectedImage: dataStructureImage)
        
        split.viewControllers = [dataNav, UINavigationController(rootViewController: about)]
        
        about.navigationItem.leftBarButtonItem = split.displayModeButtonItem
        about.navigationItem.leftItemsSupplementBackButton = true
        
        return split
    }
    
    func makeRootTabBarController() -> RootTabBarController {
        let controller = RootTabBarController()
        
        let algoNav = makeAlgorithmViewController()
        
        algorithmNav = algoNav
        
        let dataNav = makeDataStructureViewController()
        dataStructuresNav = dataNav
        
        puzzlesViewController.update(with: [puzzlesPresenter.makePuzzleSection()])
        puzzlesViewController.dispatcher = puzzlesPresenter
        
        let puzzlesNav = UINavigationController(rootViewController: puzzlesViewController)
        puzzlesNav.navigationBar.prefersLargeTitles = true
        self.puzzleNavigation = puzzlesNav
        
        puzzlesViewController.title = "Puzzles"
        puzzlesViewController.tabBarItem = UITabBarItem(title: "Puzzles",
                                          image: UIImage(named: "puzzle")?.scaledImage(withSize: CGSize(width: 30, height: 30)),
                                          tag: 0)
        
        let about = AboutViewController()
        let aboutNav = UINavigationController(rootViewController: about)
        aboutNav.navigationBar.prefersLargeTitles = true
        about.title = "About"
        about.tabBarItem = UITabBarItem(title: "About",
                                        image: UIImage(named: "info")?.scaledImage(withSize: CGSize(width: 30, height: 30)),
                                        tag: 0)
        
        controller.viewControllers = [
            algoNav,
            dataNav,
            puzzlesNav,
            about
        ]
        
        controller.coordinator = self
        
        return controller
    }
    
    private func makeMarkdownController(with markdown: String,
                                        title: String) -> MarkdownPresentationViewController {
        
        let controller = MarkdownPresentationViewController()
   
        controller.setMarkdown(markdown)
        return controller
    }
    
    private func handleCategorySelect(_ category: AlgorithmCategory) {
        
        let categoryCoordinator = CategoryCoordinator()
        
        guard let nav = categoryCoordinator.makeRoot(category) else {
            return
        }
        
        
        
        self.categoryCoordinator = categoryCoordinator
        
        algorithmNav?.present(nav, animated: true, completion: nil)
    }
    
    private func handleCategorySelect(_ category: DataStructure.Category) {
        let categoryCoordinator = CategoryCoordinator()
        
        let nav = categoryCoordinator.makeRoot(category)
        
        self.categoryCoordinator = categoryCoordinator
        
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
                    self?.algorithmMarkdownViewController.title = algorithm.title
                    self?.algorithmMarkdownViewController.setMarkdown(markdown)
                    
                    guard let markdownViewController = self?.algorithmMarkdownViewController else {
                        return
                    }
                    
                    self?.algorithmViewController.showDetailViewController(markdownViewController, sender: nil)
                }
                
            case .failure:
                return
            }
        }
    }
    
    private func handleDataStructureSelect(_ dataStructure: DataStructure) {
       
        guard let url = urlFactory.markdownFileUrl(for: dataStructure) else {
            return
        }
        
        stringNetworkService.fetchMarkdown(with: url) { [weak self] result in
            switch result {
            case let .success(markdown):
                
                DispatchQueue.main.async {
                    let markdownView = MarkdownPresentationViewController()
                    markdownView.title = dataStructure.title
                    markdownView.setMarkdown(markdown)
                    
                    self?.dataStructuresNav?.showDetailViewController(markdownView, sender: nil)
                }
                
            case .failure:
                return
            }
        }
    }
    
    private func handlePuzzleSelect(_ puzzle: Puzzle) {
        
        guard let url = urlFactory.markdownFileUrl(for: puzzle) else {
            return
        }
        
        handleMarkdownResourceSelect(with: url,
                                     resourceTitle: puzzle.title,
                                     navigationStack: puzzleNavigation)
    }
    
    private func handleMarkdownResourceSelect(with url: URL,
                                              resourceTitle: String,
                                              navigationStack: UINavigationController?) {
        
        stringNetworkService.fetchMarkdown(with: url) { [weak self] result in
            switch result {
            case let .success(markdown):
                
                DispatchQueue.main.async {
                    if let controller = self?.makeMarkdownController(with: markdown,
                                                                     title: resourceTitle) {
                        navigationStack?.pushViewController(controller, animated: true)
                    }
                }
                
            case .failure:
                return
            }
        }
    }
}


extension RootTabCoordinator: AlgorithmPresenterActionDispatching {
    func dispatch(_ action: AlgorithmPresentationAction) {
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

extension RootTabCoordinator: DataStructurePresenterActionDispatching {
    func dispatch(_ action: DataStructurePresenter.Action) {
        switch action {
        case let .selectedDataStructure(dataStructure):
            handleDataStructureSelect(dataStructure)
        case let .selectedCategory(category):
            handleCategorySelect(category)
            
        }
    }
}

extension RootTabCoordinator: DataStructureSearchPresenterDispatching {
    func dispatch(_ action: DataStructureSearchPresenter.Action) {
        switch action {
        case let .selectedDataStructure(dataStructure):
            handleDataStructureSelect(dataStructure)
            
        }
    }
}

extension RootTabCoordinator: PuzzlePresenterActionDispatching {
    func dispatch(_ action: PuzzlesPresenter.Action) {
        switch action {
        case let .selectPuzzle(puzzle):
            handlePuzzleSelect(puzzle)
        }
    }
}
