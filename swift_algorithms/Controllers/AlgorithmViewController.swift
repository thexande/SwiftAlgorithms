import UIKit

final class AlgorithmViewController: SectionProxyTableViewController {
    
    enum Action {
        case selectedItem(UUID)
    }
    
    weak var dispatcher: AlgorithmViewActionDispatching?
    
    override init(style: UITableViewStyle) {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(with sections: [TableSectionController]) {
        sections.forEach { section in
            section.registerReusableTypes(tableView: tableView)
            
            section.onSelect = { [weak self] identifier in
                self?.dispatcher?.dispatch(.selectedItem(identifier))
            }
        }
        
        self.sections = sections
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        // Setup the Search Controller
        definesPresentationContext = true
        
        hero.isEnabled = true
    }
}
