import UIKit
import Anchorage

final class ActionIconRowCell: UITableViewCell {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let icon = UIImageView()
    let labelStack = UIStackView()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var subTitle: String? {
        didSet {
            subtitleLabel.text = subTitle
            
        }
    }
    
    var iconImage: UIImage? {
        didSet {
            icon.image = iconImage
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.separatorInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        
        icon.sizeAnchors == CGSize(width: 36, height: 36)
        icon.contentMode = .scaleAspectFit
        icon.tintColor = UIColor.blue
        
        contentView.addSubview(icon)
        
        [titleLabel, subtitleLabel].forEach { view in
            labelStack.addArrangedSubview(view)
        }
        
        labelStack.axis = .vertical
        labelStack.spacing = 8
        contentView.addSubview(labelStack)
        
        
        icon.leadingAnchor == contentView.leadingAnchor + 16
        icon.centerYAnchor == contentView.centerYAnchor
        
        labelStack.leadingAnchor == icon.trailingAnchor + 18
        labelStack.verticalAnchors == contentView.verticalAnchors + 8
        labelStack.trailingAnchor == contentView.trailingAnchor - 18
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        accessoryType = .disclosureIndicator
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
