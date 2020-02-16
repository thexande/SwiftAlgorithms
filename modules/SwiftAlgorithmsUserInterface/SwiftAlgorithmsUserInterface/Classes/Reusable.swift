public protocol Reusable {
    static var reuseIdentifier: String { get }
}

public extension Reusable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
