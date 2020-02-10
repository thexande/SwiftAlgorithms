import UIKit
import Anchorage

@available(iOS 13.0, *)
public final class SideMenuItemCell: UITableViewCell, Reusable {
    private let icon = UIImageView()
    private let card = UIView()
    
    public var properties = Properties.default {
        didSet {
            if let iconProperties = properties.iconProperties {
                icon.image = iconProperties.icon?.withRenderingMode(.alwaysTemplate)
                card.backgroundColor = iconProperties.background
                textLabel?.text = "          \(properties.name)"
            } else {
                textLabel?.text = properties.name
            }
        }
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(card)
        card.sizeAnchors == CGSize(width: 36, height: 36)
        card.leadingAnchor == safeAreaLayoutGuide.leadingAnchor + 12
        card.centerYAnchor == centerYAnchor
        card.layer.cornerRadius = 6
        
        card.addSubview(icon)
        let inset: CGFloat = 6
        icon.edgeAnchors == card.edgeAnchors + UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        icon.image = nil
        textLabel?.text = nil
        card.backgroundColor = .clear
    }
}

public extension SideMenuItemCell {
    struct Properties {
        let iconProperties: IconProperties?
        let name: String
        let identifier: UUID
        static let `default` = Properties(iconProperties: nil, name: "", identifier: UUID())
        public init(iconProperties: IconProperties?, name: String, identifier: UUID) {
            self.iconProperties = iconProperties
            self.name = name
            self.identifier = identifier
        }
        public struct IconProperties {
            let background: UIColor
            let icon: UIImage?
            public init(background: UIColor, icon: UIImage) {
                self.background = background
                self.icon = icon
            }
        }
    }    
}

