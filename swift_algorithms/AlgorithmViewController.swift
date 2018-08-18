import UIKit
import DeckTransition

final class AlgorithmViewController: SectionProxyTableViewController {
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
    }
    
    @objc func presentMD() {
        let modal = MarkdownPresentationViewController()
        navigationController?.pushViewController(modal, animated: true)
    }
}
