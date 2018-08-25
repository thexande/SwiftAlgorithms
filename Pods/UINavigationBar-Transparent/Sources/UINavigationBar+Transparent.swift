//
//  UIViewController+TransparentNavBar.swift
//  TransparentNavBar
//
//  Created by Fraser on 7/03/17.
//  Copyright © 2017 Idle Hands. All rights reserved.
//

import UIKit

public extension UINavigationBar {
    
    func setBarColor(_ barColor: UIColor?) {
        
        if barColor != nil && barColor!.cgColor.alpha == 0 {
            // if transparent color then use transparent nav bar
            self.setBackgroundImage(UIImage(), for: .default)
            self.hideShadow(true)
        }
        else if barColor != nil {
            // use custom color
            self.setBackgroundImage(self.image(with: barColor!), for: .default)
            self.hideShadow(false)
        }
        else {
            // restore original nav bar color
            self.setBackgroundImage(nil, for: .default)
            self.hideShadow(false)
        }
    }
    
    func hideShadow(_ doHide: Bool) {
        self.shadowImage = doHide ? UIImage() : nil
    }
    
    func image(with color: UIColor) -> UIImage {
        let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(1.0), height: CGFloat(1.0))
        UIGraphicsBeginImageContext(rect.size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
