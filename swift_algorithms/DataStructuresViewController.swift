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
//            CategoryTileItemView.Properties(title: "Trees", image: UIImage(), backgroundColor: .turquiose()),
//            CategoryTileItemView.Properties(title: "Compress", image: UIImage(), backgroundColor: .flatRed()),
//            CategoryTileItemView.Properties(title: "Sort", image: UIImage(), backgroundColor: .amethist()),
//            CategoryTileItemView.Properties(title: "Math", image: UIImage(), backgroundColor: .orangeCream()),
//            ]
//        
//        header.configure(with: items)
    }
}
