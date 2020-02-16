import UIKit
import SwiftAlgorithmsUserInterface

@available(iOS 13.0, *)
public protocol SideMenuViewDelegate: AnyObject {
    func didSelectItem(with identifier: UUID)
    func viewDidLoad()
    func presentSearch()
}

@available(iOS 13.0, *)
public protocol SideMenuTableViewRendering: AnyObject {
    var properties: SideMenuTableViewController.Properties { get set }
}

@available(iOS 13.0, *)
public final class SideMenuTableViewController: UITableViewController, SideMenuTableViewRendering {
    
    public struct Properties {
        let sections: [Section]
        
        public init(sections: [Section]) {
            self.sections = sections
        }
        
        public struct Section {
            let items: [SideMenuItemCell.Properties]
            let title: String
            
            public init(items: [SideMenuItemCell.Properties], title: String) {
                self.items = items
                self.title = title
            }
        }
        static let `default` = Properties(sections: [])
    }
    
    public override var keyCommands: [UIKeyCommand]? {
        [
            UIKeyCommand(input: " ", modifierFlags: [], action: #selector(presentSearch))
        ]
    }
    
    @objc private func presentSearch() {
        delegate?.presentSearch()
    }
    
    public override var canBecomeFirstResponder: Bool { true }
    
    public var properties = Properties.default {
        didSet {
            tableView.reloadData()
            tableView.becomeFirstResponder()
            tableView.selectRow(at: .init(item: 0, section: 0), animated: false, scrollPosition: .top)
        }
    }
    
    public weak var delegate: SideMenuViewDelegate?

    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SideMenuItemCell.self, forCellReuseIdentifier: SideMenuItemCell.reuseIdentifier)
        delegate?.viewDidLoad()
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return properties.sections.count
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return properties.sections[section].title
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.sections[section].items.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuItemCell.reuseIdentifier) as? SideMenuItemCell else {
            return UITableViewCell()
        }

        cell.properties = properties.sections[indexPath.section].items[indexPath.row]
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(with: properties.sections[indexPath.section].items[indexPath.item].identifier)
    }
}

