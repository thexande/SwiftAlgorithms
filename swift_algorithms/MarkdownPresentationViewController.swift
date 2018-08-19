import UIKit
import MarkdownView
import Anchorage

final class MarkdownPresentationViewController: UIViewController {
    let markdownView = MarkdownView()
    
    override func loadView() {
        view = markdownView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
}
