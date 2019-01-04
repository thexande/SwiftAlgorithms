import UIKit

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
}

extension UIColor {
    static func newGreen() -> UIColor {
        return UIColor(hex: "53D86A")
    }
    
    static func newPink() -> UIColor {
        return UIColor(hex: "fd3259")
    }
    
    static func amethist() -> UIColor {
        return UIColor(hex: "595bd4")
    }
    
    static func newBlue() -> UIColor {
        return UIColor(hex: "167ffc")
    }
    
    static func coral() -> UIColor {
        return UIColor(red:1.00, green:0.32, blue:0.29, alpha:1.0)
    }
    
    static func newOrange() -> UIColor {
        return UIColor(hex: "fe9526")
    }
    
    static func newYellow() -> UIColor {
        return UIColor(hex: "ffcb3f")
    }
    
    static func newLightBlue() -> UIColor {
        return UIColor(hex: "3cabdb")
    }
    
    static var darkModeSubTitle: UIColor {
        return UIColor(red:0.56, green:0.56, blue:0.58, alpha:1.0)
    }
    
    static func darkModeTableBackground() -> UIColor {
        return UIColor(red:0.09, green:0.09, blue:0.09, alpha:1.0)
    }
    
    static func darkModeMardown() -> UIColor {
        return UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
    }
}
