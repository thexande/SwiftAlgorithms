import UIKit
import Anchorage

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
        public let identifier: UUID
        static let `default` = Properties(iconProperties: nil, name: "", identifier: UUID())
        public init(iconProperties: CategoryIconView.Properties?, name: String, identifier: UUID) {
            self.iconProperties = iconProperties
            self.name = name
            self.identifier = identifier
        }
    }
}

