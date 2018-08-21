import UIKit
import Anchorage
import Lottie

final class CategoryTileItemView: UIView {
    weak var dispatcher: AlogrithmActionDispatching?
 
    let title = UILabel()
    let lottie = UIImageView()
    
    struct Properties {
        let title: String
        let image: UIImage?
        let backgroundColor: UIColor
        let category: Algorithm.Cagegory
        static let `default` = Properties(title: " ", image: UIImage(), backgroundColor: .black, category: .math)
    }
    
    func render(_ properties: Properties) {
        title.text = properties.title
        backgroundColor = properties.backgroundColor
        lottie.image = properties.image?.withRenderingMode(.alwaysTemplate)
        layer.shadowColor =  UIColor.gray.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(title)
        addSubview(lottie)

        
        title.topAnchor == topAnchor + 8
        title.horizontalAnchors == horizontalAnchors + 15
        title.bottomAnchor <= lottie.topAnchor
        
        title.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        title.text = "Woot"
        title.textColor = .white
        title.numberOfLines = 0
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.3
        
        layer.cornerRadius = 11
        backgroundColor = .black
        
        lottie.heightAnchor == lottie.widthAnchor
        lottie.heightAnchor == heightAnchor * 0.5
        lottie.bottomAnchor == bottomAnchor - 8
        lottie.trailingAnchor == trailingAnchor - 8
        
        lottie.tintColor = .white
        
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.7
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
