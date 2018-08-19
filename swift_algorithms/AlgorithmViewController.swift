import UIKit

extension AlgorithmViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}

import UIKit

class ResultsTableViewController: SectionProxyTableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        return true
    }
}




final class AlgorithmViewController: SectionProxyTableViewController {
    weak var dispatcher: RowActionDispatching?
    let header = QuadrantSelectorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
    private let footer = DonateFooterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
    let searchResultsController: ResultsTableViewController
    let searchController: UISearchController
    
    override init(style: UITableViewStyle) {
        let searchResultsController = ResultsTableViewController()
        searchController = UISearchController(searchResultsController: searchResultsController)
        self.searchResultsController = searchResultsController
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(with sections: [TableSectionController]) {
        sections.forEach { section in
            section.registerReusableTypes(tableView: tableView)
        }
        
        self.sections = sections
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableHeaderView = header
        tableView.tableFooterView = footer
        tableView.backgroundColor = .groupTableViewBackground
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = searchResultsController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Algorithms"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
//        header
        let items = [
            QuadrantItemView.Properties(title: "Search", image: UIImage(), backgroundColor: .turquiose()),
            QuadrantItemView.Properties(title: "Compress", image: UIImage(), backgroundColor: .flatRed()),
            QuadrantItemView.Properties(title: "Sort", image: UIImage(), backgroundColor: .amethist()),
            QuadrantItemView.Properties(title: "Math", image: UIImage(), backgroundColor: .orangeCream()),
            ]
        
        header.configure(with: items)
        
        header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentMD)))
        
//        end header
        

        
        
        
    }
    
    enum Action {
        case whatAreAlgorithms
        case whyLearnAlgorithms
        case bigO
        case designTechniques
        case howToContribute
        
        case stack
        case queue
        case insertionSort
        case binarySearch
        case binarySearchTree
        case mergeSort
        case boyerMoore
        
        // Searching
        
        case linnearSearch
        case countOccurences
        case selectMinMax
        case kthLargestElement
        case selectionSampling
        case unionFind
        
        // String Search
        
        case bruteForceStringSearch
        case knuthMorrisPratt
        case rabinKarp
        case longestCommonSubsequence
        case zAlgorithm
        
        // Sorting
        
        case selectionSort
        case shellSort
        case quickSort
        case heapSort
        case introSort
        case countingSort
        case radixSort
        case topologicalSort
        case bubbleSort
        case slowSort
        
        // Compression
        
        case runLengthEncoding
        case huffmanCoding
        
        // Miscellaneous
        
        case shuffle
        case comboSort
        case convexHull
        case millerRabin
        case minimumCoin
        
        // Mathematics
        
        case gcd
        case permutationsAndCombinations
        case shuntingYard
        case karatsubaMultiplication
        case haversineDistance
        case strassenMultiplicationMatrix
        
        // Machine Learning
        
        case kMeansClustering
        case linnearRegression
        case naiveBayesClassifier
        case simulatedAnnealing
        
        
        var title: String {
            switch self {
            case .whatAreAlgorithms: return "Pancakes!"
            case .whyLearnAlgorithms: return "Why Learn?"
            case .bigO: return "Big O"
            case .designTechniques: return "Design Techniques"
            case .howToContribute: return "How To Contribute"
            default: return ""
            }
        }
    }
    
    
    @objc func presentMD() {
        let modal = MarkdownPresentationViewController()
        navigationController?.pushViewController(modal, animated: true)
    }
}
