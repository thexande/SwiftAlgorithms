import UIKit
import Anchorage
import SafariServices
import SwiftAlgorithmsDataLayer

protocol MarkdownPresentationViewRendering: AnyObject {
    func setMarkdown(for algorithm: Algorithm)
    func setMarkdown(for dataStructure: DataStructure)
    func setMarkdown(for puzzle: Puzzle)
}

final class MarkdownPresentationViewController: UIViewController {
    
    let markdownView = MarkdownView()
    let loading = TableLoadingView()
    private let stringNetworkService: StringNetworkServiceInterface
    override var canBecomeFirstResponder: Bool { false }
    
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
    
    init(stringNetworkService: StringNetworkServiceInterface = StringNetworkService()) {
        self.stringNetworkService = stringNetworkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if #available(iOS 13.0, *) {
            loading.backgroundColor = .systemBackground
        } else {
            loading.backgroundColor = .white
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
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        }
    }
}

extension MarkdownPresentationViewController: MarkdownPresentationViewRendering {
    func setMarkdown(for algorithm: Algorithm) {
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
    
    func setMarkdown(for dataStructure: DataStructure) {
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
    
    func setMarkdown(for puzzle: Puzzle) {
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
}
