import UIKit
import Anchorage
import SafariServices

final class MarkdownPresentationViewController: UIViewController {
    
    let markdownView = MarkdownView()
    let loading = TableLoadingView()
    private let stringNetworkService = StringNetworkService()
    
    public func setMarkdown(_ markdown: String) {
        
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .light {
                markdownView.visualMode = .light
            } else {
                markdownView.visualMode = .dark
            }
        } else {
            markdownView.visualMode = .light
        }
        
        view.bringSubviewToFront(loading)
        markdownView.load(markdown: markdown)
    }
    
    public func setMarkdown(for algorithm: Algorithm) {
        title = algorithm.title
        
        guard let url = UrlFactory().markdownFileUrl(for: algorithm) else {
            return
        }
        
        stringNetworkService.fetchMarkdown(with: url) { [weak self] result in
            switch result {
            case let .success(markdown):
                
                DispatchQueue.main.async {
                    self?.setMarkdown(markdown)
                }
            case .failure:
                return
            }
        }
    }
    
    public func setMarkdown(for dataStructure: DataStructure) {
        title = dataStructure.title
        
        guard let url = UrlFactory().markdownFileUrl(for: dataStructure) else {
            return
        }
        
        stringNetworkService.fetchMarkdown(with: url) { [weak self] result in
            switch result {
            case let .success(markdown):
                
                DispatchQueue.main.async {
                    self?.setMarkdown(markdown)
                }
            case .failure:
                return
            }
        }
    }
    
    public func setMarkdown(for puzzle: Puzzle) {
        title = puzzle.title
        guard let url = UrlFactory().markdownFileUrl(for: puzzle) else {
            return
        }
        
        stringNetworkService.fetchMarkdown(with: url) { [weak self] result in
            switch result {
            case let .success(markdown):
                
                DispatchQueue.main.async {
                    self?.setMarkdown(markdown)
                }
            case .failure:
                return
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
<<<<<<< HEAD
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
=======
        stringNetworkService.fetchMarkdown(with: UrlFactory().markdownFileUrl(for: .stack)!) { [weak self] result in
            switch result {
            case let .success(md):
                
                DispatchQueue.main.async {
                    self?.setMarkdown(md)
                }
                
            case .failure:
                return
            }
>>>>>>> markdown controller test
        }
        
        view.addSubview(markdownView)
        markdownView.edgeAnchors == view.edgeAnchors
        
        view.addSubview(loading)
        loading.edgeAnchors == view.edgeAnchors
        
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
        
        markdownView.onRendered = { [weak self] _ in
            if let `self` = self {
                self.view.sendSubviewToBack(self.loading)
            }
        }
    }
}
