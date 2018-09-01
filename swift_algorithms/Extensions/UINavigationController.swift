import UIKit

extension UINavigationController {
    func setTitleForgroundTitleColor(_ color: UIColor) {
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): color]
    }
    
    func setLargeTitleColor(_ color: UIColor) {
        self.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): color]
    }
    
    func setAllTitleColor(_ color: UIColor) {
        setTitleForgroundTitleColor(color)
        setLargeTitleColor(color)
    }
}

