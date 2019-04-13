import UIKit
import Anchorage
import Lottie

final class LottieLoaderView: UIView {
    let lottieView: AnimationView

    init() {
        lottieView = AnimationView(name: "legoloader")
        super.init(frame: .zero)

        [lottieView].forEach { addSubview($0) }

        lottieView.sizeAnchors == CGSize(width: 200, height: 180)
        lottieView.centerAnchors == centerAnchors
        lottieView.loopMode = .loop
        lottieView.play()

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

