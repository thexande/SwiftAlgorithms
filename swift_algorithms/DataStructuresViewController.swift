import UIKit

final class DataStructuresViewController: SectionProxyTableViewController {
    enum Actions {
        case selectedDataStructure
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        
        
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
