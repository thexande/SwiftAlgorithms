import UIKit
import Anchorage
import Lottie

final class CategoryTileItemView: UIView {
    weak var dispatcher: AlogrithmActionDispatching?
 
    let title = UILabel()
    let lottie = UIImageView()
    var verticalOffset: CGFloat = 0
    
    struct Properties {
        let title: String
        let image: UIImage?
        let backgroundColor: UIColor
        let identifier: UUID
        static let `default` = Properties(title: " ", image: UIImage(), backgroundColor: .black, identifier: UUID())
    }
    
    func render(_ properties: Properties) {
        title.text = properties.title
        backgroundColor = properties.backgroundColor
        lottie.image = properties.image?.withRenderingMode(.alwaysTemplate)
        layer.shadowColor =  UIColor.gray.cgColor
        hero.id = properties.title
        
        title.sizeToFit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        hero.modifiers = [.whenMatched(.useNoSnapshot), .spring(stiffness: 300, damping: 25)]
        
        addSubview(title)
        addSubview(lottie)

        
//        title.topAnchor == topAnchor + 8
//        title.horizontalAnchors == horizontalAnchors + 15
//        title.bottomAnchor <= lottie.topAnchor
//
        title.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        title.text = "Woot"
        title.textColor = .white
        title.numberOfLines = 0
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.3
        
        layer.cornerRadius = 11
        backgroundColor = .black
        
//        lottie.heightAnchor == lottie.widthAnchor
//        lottie.heightAnchor == heightAnchor * 0.5
//        lottie.bottomAnchor == bottomAnchor - 8
//        lottie.trailingAnchor == trailingAnchor - 8
        
        lottie.tintColor = .white
        
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 0.7
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let inset: CGFloat = 12
        title.frame = CGRect(x: inset, y: inset + verticalOffset, width: bounds.width - 40, height: 30)
        let imageWidth = bounds.height * 0.4
        lottie.frame = CGRect(x: bounds.width - inset - imageWidth, y: bounds.height - inset - imageWidth, width: imageWidth, height: imageWidth)
    }
}
