import UIKit
import Anchorage

final class CategoryCollectionCell: UICollectionViewCell, Reusable {
    let tile = CategoryTileItemView()
    let card = RoundedCardWrapperView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(card)
        card.frame = contentView.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func render(_ properties: CategoryTileItemView.Properties) {
        tile.render(properties)
        card.cardView.render(properties)
    }
}
