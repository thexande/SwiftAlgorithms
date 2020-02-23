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

enum Section: Hashable {
    case main
}

@available(macCatalyst 10.15, iOS 13, *)
public extension CatalystSearchResultsTableViewController {
    struct Properties: Equatable {
        let items: [Item]
        public static let `default` = Properties(items: [])
        
        public init(items: [Item]) {
            self.items = items
        }
        
        public struct Item: Hashable {
            let title: String
            let iconProperties: CategoryIconView.Properties
            let subtitle: String?
            let identifier: UUID

            public init(title: String,
                        iconProperties: CategoryIconView.Properties,
                        subtitle: String?,
                        identifier: UUID) {
                self.title = title
                self.iconProperties = iconProperties
                self.subtitle = subtitle
                self.identifier = identifier
            }
            
            static let `default` = Item(title: "",
                                        iconProperties: .default,
                                        subtitle: "",
                                        identifier: UUID())
        }
    }
}

@available(macCatalyst 10.15, iOS 13, *)
public final class CatalystSearchResultsTableViewController: UITableViewController, CatalystSearchResultsTableViewRendering {
    public weak var delegate: CatalystSearchResultsTableViewDelegate?
    private let empty = SearchEmptyStateView()
    private let algorithmSearchController = UISearchController(searchResultsController: nil)
    private var hasFirstRender = false
    private var selectedIndex: IndexPath?
    private var dataSource: UITableViewDiffableDataSource<Section, Properties.Item>?
    
    public var properties: Properties = .default {
        didSet {
            guard oldValue != properties else { return }
            DispatchQueue.main.async {
                self.update(with: self.properties)
            }
        }
    }
    
    private func update(with properties: Properties) {
        
        var snap = NSDiffableDataSourceSnapshot<Section, Properties.Item>()
        snap.appendSections([.main])
        
        for item in properties.items {
            snap.appendItems([item], toSection: .main)
        }
        
        
        dataSource?.apply(snap)
        
        if hasFirstRender && algorithmSearchController.searchBar.text != "" {
            let first = properties.items.first
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

        let shouldShowEmptyState = properties.items.isEmpty == true

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
    
    override public init(style: UITableView.Style) {
        super.init(style: style)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        delegate?.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.backgroundView = empty
        tableView.delegate = self
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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        
        dataSource = .init(tableView: self.tableView) { (table, indexPath, item) in
            let cell = table.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
            
            cell.backgroundColor = .clear
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
            self.delegate?.selectedItem(with: self.properties.items[index.row].identifier)
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

// MARK: - UITableViewDelegate

@available(macCatalyst 10.15, iOS 13, *)
extension CatalystSearchResultsTableViewController {
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell \(indexPath)")
        let item = properties.items[indexPath.item]

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
            
            guard text.isEmpty == false else {
                showDefaultState()
                return
            }
            
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
