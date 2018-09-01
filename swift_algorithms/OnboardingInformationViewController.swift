import UIKit
import Anchorage

final class OnboardingInformationViewController: UIViewController {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let action = PrimaryButton()
    private let actionContainer = UIView()
    public var onDismiss: (() -> Void)?
    
    struct Properties {
        let title: NSAttributedString
        let subtitle: String
        let onboardingItems: [OnboardItemView.Properties]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        titleLabel.numberOfLines = 0
        titleLabel.minimumScaleFactor = 0.35
        titleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.numberOfLines = 0
        configure(makeOnboardingProperties())
        
        action.addAction { [weak self] in
            self?.onDismiss?()
        }
    }
    
    func configure(_ properties: Properties) {
        titleLabel.attributedText = properties.title
        subtitleLabel.text = properties.subtitle
        
        let onboardItemViews: [UIView] = properties.onboardingItems.map { props in
            let view = OnboardItemView()
            view.configure(props)
            return view
        }
        
        let onboardStack = UIStackView(arrangedSubviews: onboardItemViews)
        onboardStack.axis = .vertical
        onboardStack.spacing = 24
        
        actionContainer.addSubview(action)
        action.heightAnchor == 50
        action.setTitle("Continue", for: .normal)
        action.edgeAnchors == actionContainer.edgeAnchors + UIEdgeInsets(top: 36, left: 0, bottom: 0, right: 0)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, onboardStack, actionContainer])
        stack.axis = .vertical
        stack.spacing = 36
        
        view.addSubview(stack)
        stack.horizontalAnchors == view.horizontalAnchors + 48
        stack.verticalAnchors >= view.verticalAnchors + 32
        stack.centerYAnchor == view.centerYAnchor
    }
    
    private func makeOnboardingProperties() -> Properties {
        let attributedTitle = NSMutableAttributedString()
        
        let prefixAttributes = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 42, weight: .black),
            NSAttributedStringKey.foregroundColor : UIColor.black
        ]
        
        let titleAttributes = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 42, weight: .black),
            NSAttributedStringKey.foregroundColor : UIColor.coral()
        ]
        
        let prefix = NSMutableAttributedString(string:"Welcome to ", attributes: prefixAttributes)
        
        let title = NSMutableAttributedString(string:"Algorithms ", attributes: titleAttributes)
        
        [prefix, title].forEach { string in
            attributedTitle.append(string)
        }
        
        return OnboardingInformationViewController.Properties(title: attributedTitle, subtitle: "Great documentation for Data Structures and Algorithms in Swift 4.", onboardingItems: [
            OnboardItemView.Properties(content: "View tutorials on over 50 computer science algorithms, as well as implementations.", icon: UIImage(named: "algo")),
            OnboardItemView.Properties(content: "Check out examples of arrays, queues, lists, trees and hashes implemented in Swift!", icon: UIImage(named: "data_structure")),
            OnboardItemView.Properties(content: "Sourced from Raywenderlich.com's Algorithm Club, these Markdown resources are fetched from the github repository.", icon: UIImage(named: "swift_algo_club")),
            ])
    }
}
