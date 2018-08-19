import UIKit
import Anchorage

final class BasicTableHeaderView: UITableViewHeaderFooterView {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .groupTableViewBackground
        let labels = [titleLabel, subtitleLabel]
        
        labels.forEach { label in
            label.numberOfLines = 0
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        
        let stack = UIStackView(arrangedSubviews: labels)
        stack.axis = .vertical
        stack.spacing = 12
        contentView.addSubview(stack)
        stack.edgeAnchors == contentView.edgeAnchors + UIEdgeInsets(top: 8, left: 18, bottom: 8, right: 18)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


