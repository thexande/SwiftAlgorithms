import UIKit
import Anchorage

final class CategoryCollectionCell: UICollectionViewCell, Reusable {
    let tile = CategoryTileItemView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(tile)
        tile.edgeAnchors == contentView.edgeAnchors
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func render(_ properties: CategoryTileItemView.Properties) {
        tile.render(properties)
    }
}



