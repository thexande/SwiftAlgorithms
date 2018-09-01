import UIKit
import Anchorage

final class DonateFooterView: UIView {
    let button = ConfettiButton()
//    weak var dispatcher: WalletDetailActionDispatching?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)
        button.edgeAnchors == edgeAnchors + UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
        button.setTitle("Who wrote this 🔥 app? 🤔", for: .normal)
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDonate)))
    }
    
    @objc private func showDonate() {
//        dispatcher?.dispatch(.showDonate)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
