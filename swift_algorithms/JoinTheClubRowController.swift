import UIKit
import Anchorage

final class JoinTheClubRowController: NSObject, RowController {
    public weak var dispatcher: RowActionDispatching?
    
    func registerReusableTypes(tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
}

extension JoinTheClubRowController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self)) else {
            return UITableViewCell()
        }
        let about = AboutView()
        cell.contentView.addSubview(about)
        about.edgeAnchors == cell.contentView.edgeAnchors
        cell.selectionStyle = .none
        cell.contentView.backgroundColor =
            .groupTableViewBackground
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

