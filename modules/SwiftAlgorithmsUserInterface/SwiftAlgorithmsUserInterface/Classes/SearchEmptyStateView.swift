import UIKit
import Anchorage
import Lottie

@available(iOS 10.0, *)
public final class SearchEmptyStateView: UIView {
    let titleLabel = UILabel()
    let lottieView: AnimationView
    let background = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    var isAnimationHidden: Bool = false {
        didSet {
            [titleLabel, lottieView].forEach { $0.isHidden = isAnimationHidden }
        }
    }
    
    public init() {
        lottieView = AnimationView(name: "legoloader", bundle: Bundle(for: type(of: self)), imageProvider: nil, animationCache: nil)
        super.init(frame: .zero)
        
        [background, titleLabel, lottieView].forEach { addSubview($0) }
        
        lottieView.sizeAnchors == CGSize(width: 200, height: 200)
        lottieView.centerAnchors == centerAnchors
        lottieView.loopMode = .loop
        lottieView.play()
        
        titleLabel.horizontalAnchors == horizontalAnchors + 24
        titleLabel.bottomAnchor == lottieView.topAnchor
        titleLabel.text = "No results found"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        backgroundColor = .clear
        
        background.edgeAnchors == edgeAnchors
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        lottieView.play()
    }
}
