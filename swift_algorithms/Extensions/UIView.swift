import UIKit

extension UIView {
    func installCardShadow() {
        switch Themer.shared.currentTheme {
        case .dark:
            return
        case .light:
            layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            layer.shadowRadius = 10.0
            layer.shadowOpacity = 0.7
            layer.shadowColor =  UIColor.lightGray.cgColor
        }
    }
}
