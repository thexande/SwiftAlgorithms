import UIKit
import Anchorage
import SafariServices

protocol MarkdownPresentationViewRendering: AnyObject {
    func setMarkdown(for algorithm: Algorithm)
    func setMarkdown(for dataStructure: DataStructure)
    func setMarkdown(for puzzle: Puzzle)
}

final class MarkdownPresentationViewController: UIViewController, MarkdownPresentationViewRendering {
    
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
        
        markdownView.load(markdown: markdown)
    }
    
    public func setMarkdown(for algorithm: Algorithm) {
        title = algorithm.title
        view.bringSubviewToFront(loading)
        
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
        view.bringSubviewToFront(loading)
        
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
        view.bringSubviewToFront(loading)

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
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        }
    }
}
