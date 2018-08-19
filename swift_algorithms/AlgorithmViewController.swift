import UIKit

final class AlgorithmViewController: SectionProxyTableViewController {
    
    weak var dispatcher: RowActionDispatching?
    let header = QuadrantSelectorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
    
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
        
        case linnearSearch
        case countOccurences
        case selectMinMax
        case kthLargestElement
        case selectionSampling
        case unionFind
        
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
