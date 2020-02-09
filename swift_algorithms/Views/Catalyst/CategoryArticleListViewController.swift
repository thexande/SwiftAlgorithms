import UIKit
import Anchorage

@available(iOS 13.0, *)
protocol CategoryArticleListViewRendering: AnyObject {
    var sections: [TableSectionController] { get set }
    var title: String? { get set }
}

@available(iOS 13.0, *)
protocol CategoryArticleListViewDelegate: AnyObject {
    func didSelectArticle(with identifier: UUID)
}

@available(iOS 13.0, *)
final class CategoryArticleListViewController: UIViewController, CategoryArticleListViewRendering {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    weak var delegate: CategoryArticleListViewDelegate?
    
    override func loadView() {
        view = tableView
    }
    
    var sections: [TableSectionController] = [] {
        didSet {
            update(with: sections)
        }
    }
    
    private func update(with sections: [TableSectionController]) {
        sections.forEach { section in
            section.registerReusableTypes(tableView: tableView)
            
            section.onSelect = { [weak self] identifier in
                self?.delegate?.didSelectArticle(with: identifier)
            }
        }
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sorting"
        
        self.sections =  AlgorithmSectionFactory().makeAllSortingSections().map {
            
//            for (key, value) in $0.identifiers {
//                identifiers[key] = value
//            }
            
            return $0.seciton
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

@available(iOS 13.0, *)
extension CategoryArticleListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return sections[indexPath.section].tableView?(tableView, heightForRowAt: indexPath) ?? UITableView.automaticDimension
    }
}

