import UIKit
import DeviceKit

final class CategorySideScrollingCollecitonSectionController: NSObject, CollectionSectionController {
    
    let width = UIScreen.main.bounds.width
    
    public var properties: [CategoryTileItemView.Properties] = []
    
    var onSelect: ((UUID) -> Void)?

    func registerForReusableTypes(with collectionView: UICollectionView) {
        collectionView.register(CategoryCollectionCell.self,
                                forCellWithReuseIdentifier: CategoryCollectionCell.reuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return properties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.reuseIdentifier,
                                                            for: indexPath) as? CategoryCollectionCell else {
                                                                return UICollectionViewCell()
        }
        cell.render(properties[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let device = Device()
        let width: CGFloat
        
        if device.isPad {
            width = 140
        } else {
            width = (self.width / 2.6)
        }
        
        
        return CGSize(width: width, height: collectionView.frame.height - 40)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 18, left: 12, bottom: 18, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onSelect?(properties[indexPath.row].identifier)
    }
}

