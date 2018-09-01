import UIKit

protocol PuzzlesViewActionDispatching: AnyObject {
    func dispatch(_ action: PuzzlesViewController.Action)
}

final class PuzzlesViewController: SectionProxyTableViewController {
    
    enum Action {
        case selectedItem(UUID)
    }
    
    weak var dispatcher: PuzzlesViewActionDispatching?
    
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
}
