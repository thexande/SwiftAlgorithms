import UIKit
import Anchorage

protocol CatalystSearchResultsTableViewDelegate: AnyObject {
    func searched(for term: String)
    func selectedItem(with identifier: UUID)
}

protocol CatalystSearchResultsTableViewRendering: AnyObject {
    var properties: CatalystSearchResultsTableViewController.Properties { get set }
}

extension CatalystSearchResultsTableViewController {
    struct Properties {
        let sections: [SectionProperties]
        static let `default` = Properties(sections: [])
        struct SectionProperties {
            let sectionTitle: String
            let rows: [RowProperties]
            
            struct RowProperties {
                let title: String
                let iconProperties: CategoryIconView.Properties
                let subtitle: String?
                let identifier: UUID
                static let `default` = RowProperties(title: "", iconProperties: .default, subtitle: "", identifier: UUID())
            }
        }
    }
}

final class CatalystSearchResultsTableViewController: UITableViewController, CatalystSearchResultsTableViewRendering {
        
    weak var delegate: CatalystSearchResultsTableViewDelegate?
    
    private let empty = SearchEmptyStateView()
    
    private let algorithmSearchResultsPresenter = CatalystAlgorithmSearchPresenter()
    private let algorithmSearchController = UISearchController(searchResultsController: nil)
    
    private var hasFirstRender = false
    
    var properties: Properties = .default {
        didSet {
            update(with: properties)
        }
    }
    
    private func update(with properties: Properties) {
        
        if hasFirstRender && algorithmSearchController.searchBar.text != "" {
            let first = properties.sections.first?.rows.first
            title = first?.title
            
            let icon = CategoryIconView()
            icon.sizeAnchors == CGSize(width: 36, height: 36)
            
            if let props = first?.iconProperties {
                icon.properties = props
            }
              
            navigationItem.leftBarButtonItem = .init(customView: icon)
        } else if hasFirstRender == false {
            title = "What are we looking for?"
            let icon = UIImageView(image: UIImage(named: "AppIcon"))
            icon.layer.cornerRadius = 6
            icon.clipsToBounds = true
            icon.sizeAnchors == CGSize(width: 36, height: 36)
          
            navigationItem.leftBarButtonItem = .init(customView: icon)
        }
        

        tableView.reloadData()
                
        
        if properties.sections.count > 0 {
            empty.isAnimationHidden = true
        } else {
            empty.isAnimationHidden = false
            view.bringSubviewToFront(empty)
        }
        
        hasFirstRender = true
    }
    
    override init(style: UITableView.Style) {
        if #available(iOS 13.0, *) {
            super.init(style: .plain)
        } else {
            super.init(style: .grouped)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.backgroundView = empty
        empty.isAnimationHidden = true
        
        algorithmSearchResultsPresenter.renderer = self
        
        
        algorithmSearchResultsPresenter.makeSearchableAlgorithmProperties()
        //        algorithmSearchResultsPresenter.dispatcher = self
        
        self.delegate = algorithmSearchResultsPresenter
        
        algorithmSearchController.searchResultsUpdater = self
        algorithmSearchController.delegate = self
        algorithmSearchController.obscuresBackgroundDuringPresentation = false
        algorithmSearchController.searchBar.placeholder = "Search Algorithms"
        
        algorithmSearchController.searchBar.delegate = self
        
//        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.searchController = algorithmSearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.backgroundColor = .clear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        empty.removeFromSuperview()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        algorithmSearchController.isActive = true
//        presentAlert()
    }
    
    func presentAlert() {
        let alert = UIAlertController(title: "👋 Quick Tip",
                                      message: "Looking for something? Skip the tool bar button and just press the space key next time!",
                                      preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override var keyCommands: [UIKeyCommand]? {
        [
            UIKeyCommand(input: "\r", modifierFlags: [], action: #selector(enterPress)),
            UIKeyCommand(input: UIKeyCommand.inputEscape, modifierFlags: [], action: #selector(escape)),
            UIKeyCommand(input: "\u{8}", modifierFlags: [], action: #selector(backspace)),
            UIKeyCommand(input: UIKeyCommand.inputUpArrow, modifierFlags: [], action: #selector(up)),
        ]
    }
    
    @objc private func enterPress() {
        print("pressed enter on index \(tableView.indexPathForSelectedRow!)")
    }
    
    @objc private func escape() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func backspace() {
        algorithmSearchController.isActive = true
        algorithmSearchController.searchBar.becomeFirstResponder()
    }
    
    @objc private func up() {
        guard tableView.indexPathForSelectedRow == IndexPath(item: 0, section: 0) else { return }
        algorithmSearchController.isActive = true
        algorithmSearchController.searchBar.becomeFirstResponder()
    }
}

// MARK: - UISearchControllerDelegate

extension CatalystSearchResultsTableViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CatalystSearchResultsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return properties.sections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.backgroundColor = .clear
        let item = properties.sections[indexPath.section].rows[indexPath.item]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
        
        let icon = CategoryIconView()
        icon.sizeAnchors == CGSize(width: 30, height: 30)
        icon.properties = item.iconProperties
        
        cell.contentView.addSubview(icon)
        icon.trailingAnchor == cell.trailingAnchor - 24
        icon.centerYAnchor == cell.contentView.centerYAnchor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell \(indexPath)")
    }
}

// MARK: - UISearchResultsUpdating, UISearchBarDelegate

extension CatalystSearchResultsTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        view.isHidden = false
        if let text = searchController.searchBar.text {
            delegate?.searched(for: text)

        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        tableView.becomeFirstResponder()
        tableView.selectRow(at: .init(item: 0, section: 0), animated: true, scrollPosition: .none)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
}

