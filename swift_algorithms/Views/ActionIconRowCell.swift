import UIKit
import Anchorage

class ThemableTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let view = UIView()
        view.backgroundColor = Themer.shared.currentTheme == .dark ? UIColor.darkGray : UIColor.lightGray
        selectedBackgroundView = view
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class ActionIconRowCell: ThemableTableViewCell {
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
            
            guard
                Themer.shared.currentTheme == .dark,
                iconImage?.accessibilityIdentifier == "How to contribute" ||
                iconImage?.accessibilityIdentifier == "Algorithm design techniques"
            else {
                icon.image = iconImage
                return
            }
            
            icon.image = iconImage?.withRenderingMode(.alwaysTemplate)
            icon.tintColor = .white
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.separatorInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
        
        icon.sizeAnchors == CGSize(width: 36, height: 36)
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .amethist()
        
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
        
        switch Themer.shared.currentTheme {
        case .dark:
            titleLabel.textColor = .white
            subtitleLabel.textColor = .darkModeSubTitle()
            
        case .light:
            titleLabel.textColor = .black
            subtitleLabel.textColor = .darkGray
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
