import UIKit
import Anchorage

final class BasicTableCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        detailTextLabel?.numberOfLines = 0
        textLabel?.numberOfLines = 0
        
        textLabel?.textColor = .white
        detailTextLabel?.textColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class BasicTableHeaderCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        textLabel?.numberOfLines = 0
        textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        selectionStyle = .none
        contentView.backgroundColor = .groupTableViewBackground
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


final class SearchResultsTableCell: UITableViewCell {
    let title = UILabel()
    let indicator = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(title)
        title.edgeAnchors == contentView.edgeAnchors + UIEdgeInsets(top: 12, left: 42, bottom: 12, right: 12)
        title.numberOfLines = 0
        
        title.textColor = .white
        
        contentView.addSubview(indicator)
        indicator.sizeAnchors == CGSize(width: 12, height: 12)
        indicator.layer.cornerRadius = 6
        indicator.backgroundColor = .black
        indicator.centerYAnchor == title.centerYAnchor
        indicator.leadingAnchor == contentView.leadingAnchor + 18
        indicator.installCardShadow()
        
        textLabel?.textColor = .white

        
//        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -18)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
