import UIKit

final class DataStructuresViewController: SectionProxyTableViewController {
    enum Actions {
        case selectedDataStructure
    }
    let header = QuadrantSelectorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        tableView.tableHeaderView = header
        
//        let items = [
//            QuadrantItemView.Properties(title: "Trees", image: UIImage(), backgroundColor: .turquiose()),
//            QuadrantItemView.Properties(title: "Compress", image: UIImage(), backgroundColor: .flatRed()),
//            QuadrantItemView.Properties(title: "Sort", image: UIImage(), backgroundColor: .amethist()),
//            QuadrantItemView.Properties(title: "Math", image: UIImage(), backgroundColor: .orangeCream()),
//            ]
//        
//        header.configure(with: items)
    }
}
