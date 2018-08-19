import UIKit
import DeckTransition

final class AlgorithmViewController: SectionProxyTableViewController {
    enum Action {
        case selectedAlgorithm
    }
    
    let header = QuadrantSelectorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.tableHeaderView = header
        
        let items = [
            QuadrantItemView.Properties(title: "Search", image: UIImage(), backgroundColor: .turquiose()),
            QuadrantItemView.Properties(title: "Compress", image: UIImage(), backgroundColor: .flatRed()),
            QuadrantItemView.Properties(title: "Sort", image: UIImage(), backgroundColor: .amethist()),
            QuadrantItemView.Properties(title: "Math", image: UIImage(), backgroundColor: .orangeCream()),
            ]
        
        header.configure(with: items)
        
        header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentMD)))
        
        let actionSection = ActionTableSectionController()
        actionSection.registerReusableTypes(tableView: tableView)
        
        let rowProps: [ActionTableRowController.Properties] = [
            ActionTableRowController.Properties(title: "What are algorithms and data structures? Pancakes!", subtitle: nil, icon: UIImage(named: "pancakes"), identifier: UUID()),
            ActionTableRowController.Properties(title: "Why learn algorithms?", subtitle: "Worried this isn't your cup of tea? Then read this.", icon: UIImage(named: "?"), identifier: UUID()),
            ActionTableRowController.Properties(title: "Big-O notation", subtitle: "We often say things like, 'This algorithm is O(n).' If you don't know what that means, read this first.", icon: UIImage(named: "line_chart"), identifier: UUID()),
            ActionTableRowController.Properties(title: "Algorithm design techniques", subtitle: "How do you create your own algorithms?", icon: UIImage(named: "algo")?.withRenderingMode(.alwaysTemplate), identifier: UUID()),
            ActionTableRowController.Properties(title: "How to contribute", subtitle: "Report an issue to leave feedback, or submit a pull request.", icon: UIImage(named: "git"), identifier: UUID())
            
        ]
        
        
        actionSection.rows = rowProps.map(ActionTableRowController.map)
        actionSection.registerReusableTypes(tableView: tableView)
        
        sections = [
            actionSection
        ]
        
        
        
        tableView.reloadData()
    }
    
    @objc func presentMD() {
        let modal = MarkdownPresentationViewController()
        navigationController?.pushViewController(modal, animated: true)
    }
}
