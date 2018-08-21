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
//    let cardView =  CardView()
    let contentView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundColor = .white
        
        cardView.layer.cornerRadius = 0
        cardView.layer.shadowColor = UIColor.clear.cgColor
        
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


class CardView: View {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.backgroundColor = .blue
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        subtitleLabel.font = UIFont.systemFont(ofSize: 17)
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        heroModifiers = [.whenMatched(.useNoSnapshot), .spring(stiffness: 300, damping: 25)]
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        titleLabel.frame = CGRect(x: 20, y: 30, width: bounds.width - 40, height: 30)
        subtitleLabel.frame = CGRect(x: 20, y: 70, width: bounds.width - 40, height: 30)
    }
}

class RoundedCardWrapperView: View {
    let cardView = CategoryTileItemView()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview(cardView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if cardView.superview == self {
            // this is necessary because we used useNoSnapshot modifier.
            // we don't want cardView to be resized when Hero is using it for transition
            cardView.frame = bounds
        }
    }
}
