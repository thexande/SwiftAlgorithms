import Anchorage

final class LargeHomecreenViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundView = UIVisualEffectView(effect: UIBlurEffect())
    }
}
