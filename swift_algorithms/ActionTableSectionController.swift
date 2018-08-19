import UIKit



protocol RowController: UITableViewDelegate, UITableViewDataSource {
    var dispatcher: RowActionDispatching? { get set }
    func registerReusableTypes(tableView: UITableView)
}

enum RowAction {
    case selected(UUID)
}

protocol RowActionDispatching: AnyObject {
    func dispatch(_ action: RowAction)
}

final class BasicTableCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        detailTextLabel?.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class BasicTableRowController: NSObject, RowController {
    struct Properties {
        let title: String
        let subtitle: String?
        let showsDisclosure: Bool
        let identifier: UUID
        static let `default` = Properties(title: "title", subtitle: nil, showsDisclosure: false, identifier: UUID())
    }
    
    public var properties: Properties = .default
    public weak var dispatcher: RowActionDispatching?
    
    func registerReusableTypes(tableView: UITableView) {
        tableView.register(BasicTableCell.self, forCellReuseIdentifier: String(describing: BasicTableCell.self))
    }
    
    static func map(_ properties: Properties) -> BasicTableRowController {
        let controller = BasicTableRowController()
        controller.properties = properties
        return controller
    }
}

extension BasicTableRowController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BasicTableCell.self))
        cell?.textLabel?.text = properties.title
        cell?.detailTextLabel?.text = properties.subtitle
        
        if properties.showsDisclosure {
            cell?.accessoryType = .disclosureIndicator
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

import Anchorage

final class BasicTableHeaderView: UITableViewHeaderFooterView {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        let labels = [titleLabel, subtitleLabel]
        
        labels.forEach { label in
            label.numberOfLines = 0
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        
        let stack = UIStackView(arrangedSubviews: labels)
        stack.axis = .vertical
        stack.spacing = 12
        contentView.addSubview(stack)
        stack.edgeAnchors == contentView.edgeAnchors + UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class LabelTableFooterView: UITableViewHeaderFooterView {
    let label = UILabel()
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        label.edgeAnchors == contentView.edgeAnchors + UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class BasicTableSectionController: NSObject, TableSectionController {
    public var rows: [RowController] = []
    public var sectionTitle: String?
    public var sectionSubtitle: String?
    
    public weak var dispatcher: RowActionDispatching? {
        didSet {
            rows.forEach { row in
                row.dispatcher = dispatcher
            }
        }
    }
    
    func registerReusableTypes(tableView: UITableView) {
        tableView.register(BasicTableHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: BasicTableHeaderView.self))
        
        rows.forEach { row in
            row.registerReusableTypes(tableView: tableView)
        }
    }
}

extension BasicTableSectionController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return rows[indexPath.row].tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (sectionTitle != nil) ? UITableViewAutomaticDimension : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: BasicTableHeaderView.self)) as? BasicTableHeaderView else {
            return nil
        }
        view.title = sectionTitle
        view.subtitle = sectionSubtitle
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rows[indexPath.row].tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rows[indexPath.row].tableView?(tableView, heightForRowAt: indexPath) ?? UITableViewAutomaticDimension
    }
}

final class ActionTableRowController: NSObject, RowController {
    struct Properties {
        let title: String
        let subtitle: String?
        let icon: UIImage?
        let identifier: UUID
        static let `default` = Properties(title: "Test Title", subtitle: nil, icon: UIImage(named: "pancakes"), identifier: UUID())
    }
    
    public var properties: Properties = .default
    public weak var dispatcher: RowActionDispatching?
    
    func registerReusableTypes(tableView: UITableView) {
        tableView.register(ActionIconRowCell.self, forCellReuseIdentifier: String(describing: ActionIconRowCell.self))
    }
    
    static func map(_ properties: Properties) -> ActionTableRowController {
        let controller = ActionTableRowController()
        controller.properties = properties
        return controller
    }
}

extension ActionTableRowController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ActionIconRowCell.self)) as? ActionIconRowCell else {
            return UITableViewCell()
        }
        
        cell.subTitle = properties.subtitle
        cell.title = properties.title
        cell.iconImage = properties.icon
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dispatcher?.dispatch(.selected(properties.identifier))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

final class ActionTableSectionController: NSObject, TableSectionController {
    public var rows: [RowController] = []
    public var sectionTitle: String?
    
    public weak var dispatcher: RowActionDispatching? {
        didSet {
            rows.forEach { row in
                row.dispatcher = dispatcher
            }
        }
    }
    
    func registerReusableTypes(tableView: UITableView) {
        rows.forEach { row in
            row.registerReusableTypes(tableView: tableView)
        }
    }
}

extension ActionTableSectionController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return rows[indexPath.row].tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (sectionTitle != nil) ? 38 : 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rows[indexPath.row].tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rows[indexPath.row].tableView?(tableView, heightForRowAt: indexPath) ?? UITableViewAutomaticDimension
    }
}

