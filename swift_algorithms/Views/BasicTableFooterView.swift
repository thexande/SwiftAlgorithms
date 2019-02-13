import UIKit
import Anchorage

final class BasicTableFooterView: UITableViewHeaderFooterView, Reusable {
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    let label = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(label)
        label.edgeAnchors == contentView.edgeAnchors + UIEdgeInsets.init(top: 18, left: 18, bottom: 18, right: 18)
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
