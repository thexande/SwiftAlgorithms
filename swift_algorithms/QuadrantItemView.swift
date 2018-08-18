import UIKit
import Anchorage

final class QuadrantItemView: UIView {
    let title = UILabel()
    
    struct Properties {
        let title: String
        let image: UIImage
        let backgroundColor: UIColor
        static let `default` = Properties(title: " ", image: UIImage(), backgroundColor: .black)
    }
    
    func render(_ properties: Properties) {
        title.text = properties.title
        backgroundColor = properties.backgroundColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(title)
        
        title.topAnchor == topAnchor + 8
        title.horizontalAnchors == horizontalAnchors + 15
        
        title.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        title.text = "Woot"
        title.textColor = .white
        
        layer.cornerRadius = 11
        backgroundColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
