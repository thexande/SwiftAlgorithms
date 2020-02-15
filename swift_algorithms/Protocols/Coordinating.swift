import UIKit

/// Coordinator objects which can launch conform to this protocol.
/// Other future methods in this protocol could support launching as a modal
/// or onto a `UINavigationController` stack.
protocol Launchable {
    
    /// Launch from a `UIWindow`, typically at app launch
    ///
    /// - Parameter window: a given window to launch into
    func launch(in window: UIWindow?)
}

protocol Coordinating: Launchable {
    var root: UIViewController? { get }
}

extension Coordinating {
    func launch(in window: UIWindow?) {
        window?.rootViewController = root
        window?.makeKeyAndVisible()
    }
}
