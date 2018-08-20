import UIKit
import Anchorage
import Lottie

final class SearchEmptyStateView: UIView {
    let titleLabel = UILabel()
    let lottieView: LOTAnimationView
    
    init() {
        lottieView = LOTAnimationView()
        lottieView.setAnimation(named: "Rejection")
        super.init(frame: .zero)
        
        [titleLabel, lottieView].forEach { addSubview($0) }
        
        lottieView.sizeAnchors == CGSize(width: 200, height: 200)
        lottieView.centerAnchors == centerAnchors
        lottieView.loopAnimation = true
        lottieView.play()
        
        titleLabel.horizontalAnchors == horizontalAnchors + 24
        titleLabel.bottomAnchor == lottieView.topAnchor
        titleLabel.text = "No results found, we're whaley sorry."
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lottieView.play()
    }
}

