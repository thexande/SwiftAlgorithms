import UIKit
import Anchorage

final class TableLoadingView: UIView {
    private let indicator = UIActivityIndicatorView(style: .gray)
    private let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(indicator)
        indicator.centerAnchors == centerAnchors
        indicator.sizeAnchors == CGSize(width: 80, height: 80)
        indicator.startAnimating()
        
        addSubview(title)
        title.centerXAnchor == centerXAnchor
        title.topAnchor == indicator.centerYAnchor + 18
        title.font = UIFont.systemFont(ofSize: 10)
        title.text = "Loading"
        title.textColor = UIColor.darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
