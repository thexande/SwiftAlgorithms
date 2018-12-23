import UIKit

final class ClosureProxy {
    let closure: () -> Void
    
    init(attachTo: AnyObject, closure: @escaping () -> Void) {
        self.closure = closure
        objc_setAssociatedObject(attachTo, "[\(arc4random())]", self, .OBJC_ASSOCIATION_RETAIN)
    }
    
    @objc func invoke() {
        closure()
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .primaryActionTriggered, action: @escaping () -> Void) {
        let proxy = ClosureProxy(attachTo: self, closure: action)
        addTarget(proxy, action: #selector(ClosureProxy.invoke), for: controlEvents)
    }
}
