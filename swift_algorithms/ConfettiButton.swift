import UIKit
import Anchorage

final class ConfettiButton: UIButton {
    let confetti = ConfettiView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 6
        backgroundColor = .black
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        insertSubview(confetti, at: 0)
        confetti.edgeAnchors == edgeAnchors
        confetti.startConfetti()
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

