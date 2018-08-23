import UIKit

final class CategoryRowTableRowController: NSObject, RowController {
    
    var sectionTitle: String?
    
    let collectionSectionController = CategorySideScrollingCollecitonSectionController()
   
    var onSelect: ((UUID) -> Void)? {
        didSet {
            collectionSectionController.onSelect = onSelect
        }
    }
    
    var properties: [CategoryTileItemView.Properties] = [] {
        didSet {
            collectionSectionController.properties = properties
        }
    }
    
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

