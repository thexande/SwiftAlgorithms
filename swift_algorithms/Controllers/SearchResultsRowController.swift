import UIKit

final class SearchResultsRowController: NSObject, RowController {
    
    struct Properties {
        let title: String
        let indicatorColor: UIColor
        let identifier: UUID
        static let `default` = Properties(title: "", indicatorColor: .black, identifier: UUID())
    }
    
    var onSelect: ((UUID) -> Void)?

    public var properties: Properties = .default
    
    func registerReusableTypes(tableView: UITableView) {
        tableView.register(SearchResultsTableCell.self, forCellReuseIdentifier: String(describing: SearchResultsTableCell.self))
    }
    
    static func map(_ properties: Properties) -> SearchResultsRowController {
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
        // render here
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchResultsTableCell.self)) as? SearchResultsTableCell else {
            return UITableViewCell()
        }
        cell.title.text = properties.title
        cell.accessoryType = .disclosureIndicator
        cell.indicator.backgroundColor = properties.indicatorColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelect?(properties.identifier)
    }
}
