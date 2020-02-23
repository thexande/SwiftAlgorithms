import UIKit
import Anchorage

@available(macCatalyst 10.15, iOS 13, *)
public protocol CatalystSearchResultsTableViewDelegate: AnyObject {
    func searched(for term: String)
    func selectedItem(with identifier: UUID)
    func viewDidLoad()
}

@available(macCatalyst 10.15, iOS 13, *)
public protocol CatalystSearchResultsTableViewRendering: AnyObject {
    var properties: CatalystSearchResultsTableViewController.Properties { get set }
}

@available(macCatalyst 10.15, iOS 13, *)
public extension CatalystSearchResultsTableViewController {
    struct Properties {
        let sections: [SectionProperties]
        public static let `default` = Properties(sections: [])
        
        public init(sections: [SectionProperties]) {
            self.sections = sections
        }
        
        public struct SectionProperties {
            let sectionTitle: String
            let rows: [RowProperties]
            
            public init(sectionTitle: String, rows: [RowProperties]) {
                self.sectionTitle = sectionTitle
                self.rows = rows
            }
            
            public struct RowProperties {
                let title: String
                let iconProperties: CategoryIconView.Properties
                let subtitle: String?
                let identifier: UUID
                
                public init(title: String, iconProperties: CategoryIconView.Properties, subtitle: String?, identifier: UUID) {
                    self.title = title
                    self.iconProperties = iconProperties
                    self.subtitle = subtitle
                    self.identifier = identifier
                }
                static let `default` = RowProperties(title: "", iconProperties: .default, subtitle: "", identifier: UUID())
            }
        }
    }
}

@available(macCatalyst 10.15, iOS 13, *)
public final class CatalystSearchResultsTableViewController: UIViewController, CatalystSearchResultsTableViewRendering {
    public weak var delegate: CatalystSearchResultsTableViewDelegate?
    private let empty = SearchEmptyStateView()
    private let algorithmSearchController = UISearchController(searchResultsController: nil)
    private var hasFirstRender = false
    private let tableView = UITableView()
    private var selectedIndex: IndexPath?
        
    public override func loadView() {
        view = tableView
    }
    
    public var properties: Properties = .default {
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
           showDefaultState()
        }
        

        tableView.reloadData()
                
        let shouldShowEmptyState = properties.sections.first?.rows.isEmpty == true
        
        if shouldShowEmptyState {
            empty.isAnimationHidden = false
            view.bringSubviewToFront(empty)
            showDefaultState()
        } else {
            empty.isAnimationHidden = true
        }
        
        hasFirstRender = true
    }
    
    private func showDefaultState() {
        title = "What are we looking for?"
        let icon = UIImageView(image: UIImage(named: "AppIcon"))
        icon.layer.cornerRadius = 6
        icon.clipsToBounds = true
        icon.sizeAnchors == CGSize(width: 36, height: 36)
        
        navigationItem.leftBarButtonItem = .init(customView: icon)
    }
    

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        delegate?.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        tableView.backgroundView = empty
        empty.isAnimationHidden = true
        
        algorithmSearchController.searchResultsUpdater = self
        algorithmSearchController.delegate = self
        algorithmSearchController.obscuresBackgroundDuringPresentation = false
        algorithmSearchController.searchBar.placeholder = "Search Algorithms"
        
        algorithmSearchController.searchBar.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.searchController = algorithmSearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.backgroundColor = .clear
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        empty.removeFromSuperview()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        algorithmSearchController.isActive = true
    }
    
    public override var keyCommands: [UIKeyCommand]? {
        [
            UIKeyCommand(input: "\r", modifierFlags: [], action: #selector(enterPress)),
            UIKeyCommand(input: UIKeyCommand.inputEscape, modifierFlags: [], action: #selector(escape)),
            UIKeyCommand(input: "\u{8}", modifierFlags: [], action: #selector(backspace)),
            UIKeyCommand(input: UIKeyCommand.inputUpArrow, modifierFlags: [], action: #selector(up)),
        ]
    }
    
    @objc private func enterPress() {
        guard let index = tableView.indexPathForSelectedRow else { return }
        print("pressed enter on index \(index)")
        DispatchQueue.main.async {
            self.delegate?.selectedItem(with: self.properties.sections[index.section].rows[index.row].identifier)
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
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

@available(macCatalyst 10.15, iOS 13, *)
extension CatalystSearchResultsTableViewController: UISearchControllerDelegate {
    public func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

@available(macCatalyst 10.15, iOS 13, *)
extension CatalystSearchResultsTableViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return properties.sections.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.sections[section].rows.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell \(indexPath)")
        let item = properties.sections[indexPath.section].rows[indexPath.item]
        
        if let selectedIndexPath = selectedIndex, selectedIndexPath == indexPath {
            delegate?.selectedItem(with: item.identifier)
            self.navigationController?.dismiss(animated: true, completion: nil)
            return
        }
        
        self.selectedIndex = indexPath
        title = item.title
        let icon = CategoryIconView()
        icon.sizeAnchors == CGSize(width: 36, height: 36)
        icon.properties = item.iconProperties
        navigationItem.leftBarButtonItem = .init(customView: icon)
    }
}

// MARK: - UISearchResultsUpdating, UISearchBarDelegate

@available(macCatalyst 10.15, iOS 13, *)
extension CatalystSearchResultsTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    public func updateSearchResults(for searchController: UISearchController) {
        view.isHidden = false
        if let text = searchController.searchBar.text {
            if text.isEmpty { showDefaultState() }
            delegate?.searched(for: text)
        }
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        tableView.becomeFirstResponder()
        tableView.selectRow(at: .init(item: 0, section: 0), animated: true, scrollPosition: .none)
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
    
    public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
}


