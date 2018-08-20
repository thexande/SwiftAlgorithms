import UIKit

final class AlgorithmViewController: SectionProxyTableViewController {
    weak var dispatcher: RowActionDispatching?
    let header = QuadrantSelectorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
    private let footer = DonateFooterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
    
    override init(style: UITableViewStyle) {
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
        definesPresentationContext = true
        
//        header
        let items = [
            QuadrantItemView.Properties(title: "Search", image: UIImage(named: "search"), backgroundColor: .turquiose()),
            QuadrantItemView.Properties(title: "Compress", image: UIImage(named: "zip"), backgroundColor: .flatRed()),
            QuadrantItemView.Properties(title: "Sort", image: UIImage(named: "filter"), backgroundColor: .amethist()),
            QuadrantItemView.Properties(title: "Math", image: UIImage(named: "math"), backgroundColor: .orangeCream()),
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
        
        // getting started
        
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
        
        static func category(for action: Action) -> Action.Cagegory? {
            switch action {
                
            // getting started
            case .stack, .queue, .insertionSort, .binarySearch, .binarySearchTree, .mergeSort, .boyerMoore:
                return .gettingStarted
                
            // Searching
            case .linnearSearch, .countOccurences, .selectMinMax, .kthLargestElement, .selectionSampling, .unionFind:
                return .searching
                
            // String Search
            case .bruteForceStringSearch, .knuthMorrisPratt, .rabinKarp, .longestCommonSubsequence, .zAlgorithm:
                return .stringSearch
                
            // Sorting
            case .selectionSort, .shellSort, .quickSort, .heapSort, .introSort, .countingSort, .radixSort, .topologicalSort, .bubbleSort, .slowSort:
                return .sorting
                
            // Compression
            case .runLengthEncoding, .huffmanCoding:
                return .compression
                
            // Miscellaneous
            case .shuffle, .comboSort, .convexHull, .millerRabin, .minimumCoin:
                return .misc
                
            // Mathematics
            case .gcd, .permutationsAndCombinations, .shuntingYard, .karatsubaMultiplication, .haversineDistance, .strassenMultiplicationMatrix:
                return .math
                
            // Machine Learning
            case .kMeansClustering, .linnearRegression, .naiveBayesClassifier, .simulatedAnnealing:
                return .machineLearning
                
            default:
                return nil
            }
        }
        
        enum Cagegory {
            case gettingStarted
            case searching
            case stringSearch
            case sorting
            case compression
            case misc
            case math
            case machineLearning
            
            var title: String {
                switch self {
                case .gettingStarted:
                    return "Getting Started"
                case .searching:
                    return "Searching"
                case .stringSearch:
                    return "String Search"
                case .sorting:
                    return "Sorting"
                case .compression:
                    return "Compression"
                case .misc:
                    return "Miscellaneous"
                case .math:
                    return "Math"
                case .machineLearning:
                    return "Machine Learning"
                }
            }
            
            var color: UIColor {
                switch self {
                case .gettingStarted:
                    return .black
                case .searching:
                    return UIColor.turquiose()
                case .stringSearch:
                    return UIColor.amethist()
                case .sorting:
                    return UIColor.amethist()
                case .compression:
                    return UIColor.coral()
                case .misc:
                    return UIColor.blue
                case .math:
                    return UIColor.orangeCream()
                case .machineLearning:
                    return UIColor.orangeCream()
                }
            }
        }
    }
    
    
    @objc func presentMD() {
        let modal = MarkdownPresentationViewController()
        navigationController?.pushViewController(modal, animated: true)
    }
}
