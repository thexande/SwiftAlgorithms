import UIKit

protocol TableSectionController: UITableViewDelegate, UITableViewDataSource {
//    var dispatcher: WalletDetailActionDispatching? { get set }
    var sectionTitle: String? { get }
    func registerReusableTypes(tableView: UITableView)
}


class SectionProxyTableViewController: UITableViewController {
    var sections: [TableSectionController] = []
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].tableView(tableView, numberOfRowsInSection: section)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (sections[section].tableView?(tableView, heightForHeaderInSection: section)) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sections[section].tableView?(tableView, viewForHeaderInSection: section)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sections[indexPath.section].tableView?(tableView, didSelectRowAt: indexPath)
        //Change the selected background view of the cell after selection.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].tableView?(tableView, heightForRowAt: indexPath) ?? UITableViewAutomaticDimension
    }
}


