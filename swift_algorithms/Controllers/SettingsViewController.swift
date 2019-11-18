import UIKit

final class SettingsViewController: UITableViewController {
    
    struct Properties {
        let sections: [Section]
        struct Section {
            let rows: [Row]
            struct Row {
                let title: String
            }
        }
    }
    
    init() {
        if #available(iOS 13.0, *) {
            super.init(style: .insetGrouped)
        } else {
            super.init(style: .grouped)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
    }
}
