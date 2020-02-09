import UIKit
import Anchorage

@available(iOS 13.0, *)
final class CategoryContainerViewController: UIViewController {
    let markdownView = MarkdownPresentationViewController()
    let categoryArticleList = UINavigationController(rootViewController: CategoryArticleListViewController())
    
    private let stack = UIStackView()
    
    override func loadView() {
        view = stack
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryArticleList.willMove(toParent: self)
        view.addSubview(categoryArticleList.view)
        stack.addArrangedSubview(categoryArticleList.view)
        categoryArticleList.didMove(toParent: self)
        
        markdownView.willMove(toParent: self)
        view.addSubview(markdownView.view)
        stack.addArrangedSubview(markdownView.view)
        markdownView.didMove(toParent: self)
        categoryArticleList.view.widthAnchor == view.widthAnchor * 0.25 ~ .high
        categoryArticleList.view.widthAnchor >= 320
    }
}

@available(iOS 13.0, *)
final class CategoryArticleListViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var identifiers = [UUID: AlgorithmPresentationAction]()
    
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
                print(self?.identifiers[identifier])
//                                   self?.onSelect?(identifier)
            }
        }
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sorting"
        
        self.sections =  AlgorithmSectionFactory().makeAllSortingSections().map {
            
            for (key, value) in $0.identifiers {
                identifiers[key] = value
            }
            
            return $0.seciton
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

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

