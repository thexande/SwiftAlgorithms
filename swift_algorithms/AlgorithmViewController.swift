import UIKit

final class AlgorithmViewController: SectionProxyTableViewController {
    
    enum Action {
        case selectCategory(Category)
        case selectAlgorithm(Algorithm)
    }
    
    weak var dispatcher: AlogrithmActionDispatching?
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
        let items: [QuadrantItemView.Properties] = [
            QuadrantItemView.Properties(title: "Search", image: UIImage(named: "search"), backgroundColor: .turquiose(), category: .math),
            QuadrantItemView.Properties(title: "Compress", image: UIImage(named: "zip"), backgroundColor: .flatRed(), category: .math),
            QuadrantItemView.Properties(title: "Sort", image: UIImage(named: "filter"), backgroundColor: .amethist(), category: .math),
            QuadrantItemView.Properties(title: "Math", image: UIImage(named: "math"), backgroundColor: .orangeCream(), category: .math),
            ]
        
        header.configure(with: items)
    }
}
