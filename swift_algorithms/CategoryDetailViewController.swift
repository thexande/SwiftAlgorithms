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
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let status = UIApplication.shared.statusBarFrame.height
        cardView.verticalOffset = status + 12
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundColor = .white
        
        cardView.layer.cornerRadius = 0
        cardView.layer.shadowColor = UIColor.clear.cgColor
        
        addSubview(tableView)
        addSubview(cardView)
        
        tableView.hero.modifiers = [.useNoSnapshot, .translate(y: -80), .fade]
        
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
        cardView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 110)
        tableView.frame = CGRect(x: 0, y: 110, width: bounds.width, height: bounds.height)
    }
}

class CategoryDetailViewController: UIViewController {
    
    let detail = CategoryDetailView()
    
    var sections: [TableSectionController] = []
    
    override func loadView() {
        view = detail
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hero.isEnabled = true
        detail.tableView.delegate = self
        detail.tableView.dataSource = self
        detail.tableView.backgroundColor = UIColor.groupTableViewBackground
    }
    
    public func update(with sections: [TableSectionController]) {
        sections.forEach { section in
            section.registerReusableTypes(tableView: detail.tableView)
        }
        
        self.sections = sections
        detail.tableView.reloadData()
    }
}

extension CategoryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (sections[section].tableView?(tableView, heightForHeaderInSection: section)) ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sections[section].tableView?(tableView, viewForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sections[indexPath.section].tableView?(tableView, didSelectRowAt: indexPath)
        //Change the selected background view of the cell after selection.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].tableView?(tableView, heightForRowAt: indexPath) ?? UITableViewAutomaticDimension
    }
}


final class RoundedCardWrapperView: View {
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
