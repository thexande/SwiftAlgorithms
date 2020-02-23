import UIKit
import Anchorage

public final class CategoryIconView: UIView {
    
    private let icon = UIImageView()
    private let card = UIView()
    
    public var properties = Properties.default {
        didSet {
            icon.image = properties.icon?.withRenderingMode(.alwaysTemplate)
            card.backgroundColor = properties.background
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(card)
        card.edgeAnchors == edgeAnchors
        card.layer.cornerRadius = 6
        
        card.addSubview(icon)
        let inset: CGFloat = 6
        icon.edgeAnchors == card.edgeAnchors + UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareForReuse() {
        icon.image = nil
        card.backgroundColor = .clear
    }
}

public extension CategoryIconView {
    struct Properties: Hashable {
        let background: UIColor
        let icon: UIImage?
        public init(background: UIColor, icon: UIImage?) {
            self.background = background
            self.icon = icon
        }
        static let `default` = Properties(background: .black, icon: nil)
    }
}

