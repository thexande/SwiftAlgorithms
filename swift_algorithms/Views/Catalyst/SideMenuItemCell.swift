import UIKit
import Anchorage

final class SideMenuItemCell: UITableViewCell, Reusable {
    
    struct Properties {
        let background: UIColor
        let icon: UIImage?
        let name: String
        static let `default` = Properties(background: .green, icon: nil, name: "")
    }
    
    private let icon = UIImageView()
    private let card = UIView()
    
    var properties = Properties.default {
        didSet {
            textLabel?.text = "          \(properties.name)"
            icon.image = properties.icon?.withRenderingMode(.alwaysTemplate)
            card.backgroundColor = properties.background
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

