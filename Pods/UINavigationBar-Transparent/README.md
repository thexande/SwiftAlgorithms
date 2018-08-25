A UIViewController category that can make the navigation bar transparent

## Description

UIViewController+TransparentNavBar is a category that allows you to set your UINavigationBar background to transparent or to any UIColor you choose.

Because its a UIViewController category, the UINavigationBar background can be changed each time a UIViewController is pushed or popped into the navigation hierarchy.

## How to install

Add this to your CocoaPods Podfile.
```
pod 'UIViewController-TransparentNavBar'
```

## How to use

In your UIViewController
```objective-c
#import "UIViewController+TransparentNavBar.h"
```
```objective-c
- (void)viewWillAppear:(BOOL)animated {
    // to set transparent
    [self setNavBarColor:[UIColor clearColor]];
    
    // to set a custom color
    [self setNavBarColor:[UIColor yellowColor]];

    // to set back to default grey color
    [self setNavBarColor:nil];
}
```

## Treat yourself to these other libraries of mine

An elegant solution for keeping any UIView visible when the keyboard is being shown https://github.com/IdleHandsApps/IHKeyboardAvoiding

Tap to dismiss the keyboard with IHKeyboardDismissing 
https://github.com/IdleHandsApps/IHKeyboardDismissing

A drop in nav controller with cool parallax transitions https://github.com/IdleHandsApps/IHParallaxNavigationController

## Author

* Fraser Scott-Morrison (fraserscottmorrison@me.com)

## License 

Distributed under the MIT License
