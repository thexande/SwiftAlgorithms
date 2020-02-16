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
    struct Properties {
        let background: UIColor
        let icon: UIImage?
        public init(background: UIColor, icon: UIImage?) {
            self.background = background
            self.icon = icon
        }
        static let `default` = Properties(background: .black, icon: nil)
    }
}

@available(iOS 13.0, *)
public final class SideMenuItemCell: UITableViewCell, Reusable {
    private let icon = CategoryIconView()
    
    public var properties = Properties.default {
        didSet {
            if let iconProperties = properties.iconProperties {
                icon.properties = iconProperties
                textLabel?.text = "          \(properties.name)"
            } else {
                textLabel?.text = properties.name
            }
        }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(icon)
        icon.sizeAnchors == CGSize(width: 36, height: 36)
        icon.leadingAnchor == safeAreaLayoutGuide.leadingAnchor + 12
        icon.centerYAnchor == centerYAnchor
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
        icon.prepareForReuse()
    }
}

@available(iOS 13.0, *)
public extension SideMenuItemCell {
    struct Properties {
        let iconProperties: CategoryIconView.Properties?
        let name: String
        let identifier: UUID
        static let `default` = Properties(iconProperties: nil, name: "", identifier: UUID())
        public init(iconProperties: CategoryIconView.Properties?, name: String, identifier: UUID) {
            self.iconProperties = iconProperties
            self.name = name
            self.identifier = identifier
        }
    }
}
