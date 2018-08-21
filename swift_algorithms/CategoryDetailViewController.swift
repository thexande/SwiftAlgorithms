import UIKit
import Hero

class View: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewDidLoad()
    }
    
    func viewDidLoad() {}
    
    var parentViewController: UIViewController? {
        var responder: UIResponder? = self
        while responder is UIView {
            responder = responder!.next
        }
        return responder as? UIViewController
    }
    
}

final class CategoryDetailView: View {
    
    let cardView = CategoryTileItemView()
    let contentView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundColor = .white
        
        addSubview(contentView)
        addSubview(cardView)
        
        contentView.hero.modifiers = [.useNoSnapshot, .translate(y: -200), .fade]
        
        cardView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(pan(gr:))))
    }
    @objc func pan(gr: UIPanGestureRecognizer) {
        let translation = gr.translation(in: self)
        switch gr.state {
        case .began:
            parentViewController?.dismiss(animated: true, completion: nil)
        case .changed:
            Hero.shared.update(translation.y / bounds.height)
        default:
            let velocity = gr.velocity(in: self)
            if ((translation.y + velocity.y) / bounds.height) > 0.5 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 180)
        contentView.frame = CGRect(x: 0, y: 180, width: bounds.width, height: bounds.height)
    }
}

class CategoryDetailViewController: UIViewController {
    let detail = CategoryDetailView()
    
    override func loadView() {
        view = detail
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hero.isEnabled = true
    }
}

