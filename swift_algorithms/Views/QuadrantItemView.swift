import UIKit
import Anchorage
import Lottie

final class CategoryTileItemView: UIView {
    
    let title = UILabel()
    let lottie = UIImageView()
    var verticalOffset: CGFloat = 0
    
    struct Properties {
        let title: String
        let image: UIImage?
        let backgroundColor: UIColor
        let identifier: UUID
        static let `default` = Properties(title: " ", image: UIImage(), backgroundColor: .black, identifier: UUID())
        
        init(title: String, image: UIImage?, backgroundColor: UIColor, identifier: UUID) {
            self.title = title
            self.image = image
            self.backgroundColor = backgroundColor
            self.identifier = identifier
        }
        
        init(_ category: AlgorithmCategory) {
            self.title = category.title
            self.image = category.image
            self.backgroundColor = category.color
            self.identifier = UUID()
        }
        
        init(_ category: DataStructure.Category) {
            self.title = category.title
            self.image = category.image
            self.backgroundColor = category.color
            self.identifier = UUID()
        }
    }
    
    func render(_ properties: Properties) {
        title.text = properties.title
        backgroundColor = properties.backgroundColor
        lottie.image = properties.image?.withRenderingMode(.alwaysTemplate)
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
        title.textColor = .white
        title.numberOfLines = 0
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.3
        
        layer.cornerRadius = 11
        
        lottie.contentMode = .scaleAspectFit
        
        //        lottie.heightAnchor == lottie.widthAnchor
        //        lottie.heightAnchor == heightAnchor * 0.5
        //        lottie.bottomAnchor == bottomAnchor - 8
        //        lottie.trailingAnchor == trailingAnchor - 8
        
        lottie.tintColor = .white
        
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .light {
                installCardShadow()
            } else {
                removeCardShadow()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let inset: CGFloat = 12
        title.frame = CGRect(x: inset, y: inset + verticalOffset, width: bounds.width - 40, height: 30)
        let imageWidth = bounds.height * 0.4
        lottie.frame = CGRect(x: bounds.width - inset - imageWidth, y: bounds.height - inset - imageWidth, width: imageWidth, height: imageWidth)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
