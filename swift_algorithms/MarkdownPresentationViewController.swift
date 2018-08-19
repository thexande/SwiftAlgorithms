import UIKit
import MarkdownView
import Anchorage
import SafariServices

final class MarkdownPresentationViewController: UIViewController {
    let markdownView = MarkdownView()
    
    override func loadView() {
        view = markdownView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        markdownView.onTouchLink = { [weak self] request in
            guard let url = request.url else { return false }
            
            if url.scheme == "file" {
                return false
            } else if url.scheme == "http" || url.scheme == "https" {
                let safari = SFSafariViewController(url: url)
                self?.present(safari, animated: true, completion: nil)
                return false
            } else {
                return false
            }
        }
    }
}
