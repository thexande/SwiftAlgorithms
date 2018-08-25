import UIKit

protocol DataStructruesViewActionDispatching: AnyObject {
    func dispatch(_ action: DataStructuresViewController.Action)
}

final class DataStructuresViewController: SectionProxyTableViewController {
    
    enum Action {
        case selectedItem(UUID)
    }
    
    weak var dispatcher: DataStructruesViewActionDispatching?
    
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
        title = "Data Structures"
        
        // Setup the Search Controller
        definesPresentationContext = true
    }
}
