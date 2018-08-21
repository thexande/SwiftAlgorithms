import UIKit

final class CategoryRowTableSectionController: NSObject, TableSectionController {
    var sectionTitle: String?
    
    var properties: [CategoryTileItemView.Properties] = [] {
        didSet {
            collectionSectionController.properties = properties
        }
    }
    
    let collectionSectionController = CategorySideScrollingCollecitonSectionController()
    
    func registerReusableTypes(tableView: UITableView) {
        tableView.register(CategoryRowTableCell.self, forCellReuseIdentifier: CategoryRowTableCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryRowTableCell.reuseIdentifier) as? CategoryRowTableCell else {
            return UITableViewCell()
        }
        
        collectionSectionController.registerForReusableTypes(with: cell.colleciton)
        cell.colleciton.delegate = collectionSectionController
        cell.colleciton.dataSource = collectionSectionController
        
        return cell
    }
}

