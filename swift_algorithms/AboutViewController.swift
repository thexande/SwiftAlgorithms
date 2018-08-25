import UIKit
import UINavigationBar_Transparent
import Anchorage

final class AboutViewController: UIViewController {
    let confetti = ConfettiView()
    let scroll = UIScrollView()
    let about = AboutView()
    let blur = UIView()
    
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
        scroll.edgeAnchors == view.edgeAnchors
        
        scroll.addSubview(about)
        about.widthAnchor == view.widthAnchor
        about.horizontalAnchors == scroll.horizontalAnchors
        about.topAnchor == scroll.topAnchor
        scroll.bottomAnchor == about.bottomAnchor
        
        
        confetti.startConfetti()
       
        
        blur.alpha = 0.5
    }
}


