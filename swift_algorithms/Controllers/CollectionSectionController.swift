import UIKit
import Anchorage

protocol CollectionSectionController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func registerForReusableTypes(with collectionView: UICollectionView)
}

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
