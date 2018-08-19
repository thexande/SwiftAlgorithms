import UIKit
import Anchorage

final class LabelTableFooterView: UITableViewHeaderFooterView {
    let label = UILabel()
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        label.edgeAnchors == contentView.edgeAnchors + UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
