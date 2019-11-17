import UIKit
import Anchorage

final class AboutViewController: UIViewController {
    
    private let confetti = ConfettiView()
    private let scroll = UIScrollView()
    private let about = AboutView()
    private let blur = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(confetti)
        confetti.edgeAnchors == view.edgeAnchors
        
        view.addSubview(blur)
        blur.edgeAnchors == view.edgeAnchors
        
        view.addSubview(scroll)
        scroll.edgeAnchors == view.safeAreaLayoutGuide.edgeAnchors
        
        scroll.addSubview(about)
        about.widthAnchor == view.widthAnchor
        about.horizontalAnchors == scroll.horizontalAnchors
        about.topAnchor == scroll.topAnchor + 18
        scroll.bottomAnchor == about.bottomAnchor
        
        confetti.startConfetti()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
    }
}


