import UIKit
import Anchorage

final class OnboardItemView: UIView {
    private let iconView = UIImageView()
    private let iconContainer = UIView()
    private let contentLabel = UILabel()
    
    struct Properties {
        let content: String
        let icon: UIImage?
    }
    
    func configure(_ properties: Properties) {
        iconView.image = properties.icon
        contentLabel.text = properties.content
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stack = UIStackView(arrangedSubviews: [iconContainer, contentLabel])
        stack.spacing = 18
        iconView.sizeAnchors == CGSize(width: 52, height: 52)
        iconContainer.addSubview(iconView)
        iconView.edgeAnchors == iconContainer.edgeAnchors + UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        addSubview(stack)
        stack.edgeAnchors == edgeAnchors
        
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        contentLabel.numberOfLines = 0
        contentLabel.minimumScaleFactor = 0.5
        contentLabel.adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
