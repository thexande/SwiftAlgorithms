import UIKit

final class SearchResultsRowController: NSObject, RowController {

    public var properties: BasicTableRowController.Properties = .default
    public weak var dispatcher: AlogrithmActionDispatching?
    
    func registerReusableTypes(tableView: UITableView) {
        tableView.register(SearchResultsTableCell.self, forCellReuseIdentifier: String(describing: SearchResultsTableCell.self))
    }
    
    static func map(_ properties: BasicTableRowController.Properties) -> SearchResultsRowController {
        let controller = SearchResultsRowController()
        controller.properties = properties
        return controller
    }
}

extension SearchResultsRowController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchResultsTableCell.self)) as? SearchResultsTableCell else {
            return UITableViewCell()
        }
        cell.title.text = properties.title
        cell.accessoryType = .disclosureIndicator
        cell.indicator.backgroundColor = (Algorithm.category(for: properties.action)?.color ?? .black)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dispatcher?.dispatch(.selectAlgorithm(properties.action))
    }
}
