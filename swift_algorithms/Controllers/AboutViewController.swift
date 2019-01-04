import UIKit
import Anchorage

final class AboutViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let confetti = ConfettiView()
    private let scroll = UIScrollView()
    private let about = AboutView()
    private let blur = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        confetti.backgroundColor = .white
        
        view.addSubview(confetti)
        confetti.edgeAnchors == view.edgeAnchors
        
        view.addSubview(blur)
        blur.backgroundColor = .white
        blur.edgeAnchors == view.edgeAnchors
        
        view.addSubview(scroll)
        scroll.edgeAnchors == view.safeAreaLayoutGuide.edgeAnchors
        
        scroll.addSubview(about)
        about.widthAnchor == view.widthAnchor
        about.horizontalAnchors == scroll.horizontalAnchors
        about.topAnchor == scroll.topAnchor + 18
        scroll.bottomAnchor == about.bottomAnchor
        
        confetti.startConfetti()
        confetti.backgroundColor = .darkModeTableBackground()
       
        confetti.alpha = 0.8
        
        blur.alpha = 0.0
    }
}


