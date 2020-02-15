import UIKit
import Anchorage

public final class OnboardingInformationViewController: UIViewController {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let action = PrimaryButton()
    private let actionContainer = UIView()
    public var onDismiss: (() -> Void)?
    private let hint = UILabel()
    
    struct Properties {
        let title: NSAttributedString
        let subtitle: String
        let onboardingItems: [OnboardItemView.Properties]
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
        }
        
        titleLabel.numberOfLines = 0
        titleLabel.minimumScaleFactor = 0.35
        titleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.numberOfLines = 0
        configure(makeOnboardingProperties())
        
        action.addAction { [weak self] in
            self?.onDismiss?()
        }
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        view.addSubview(hint)
        hint.horizontalAnchors == view.horizontalAnchors + 18
        hint.topAnchor == stack.bottomAnchor + 18
        
        hint.font = UIFont.preferredFont(forTextStyle: .callout)
        // hint.text = "👋 While using the app, shake your device to enable dark mode!"
        hint.textAlignment = .center
        hint.textColor = .darkGray
        hint.numberOfLines = 0
    }
    
    private func makeOnboardingProperties() -> Properties {
        let attributedTitle = NSMutableAttributedString()
        let color: UIColor
        
        if #available(iOS 13.0, *) {
           color = UIColor.systemGray2
        } else {
            color = .black
        }
        
        let prefixAttributes = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 42, weight: .black),
            NSAttributedString.Key.foregroundColor : color
        ]
        
        let titleAttributes = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 42, weight: .black),
            NSAttributedString.Key.foregroundColor : UIColor.coral()
        ]
        
        let prefix = NSMutableAttributedString(string:"Welcome to ", attributes: prefixAttributes)
        
        let title = NSMutableAttributedString(string:"Algorithms ", attributes: titleAttributes)
        
        [prefix, title].forEach { string in
            attributedTitle.append(string)
        }
        
        return OnboardingInformationViewController.Properties(title: attributedTitle, subtitle: "Great documentation for Data Structures and Algorithms in Swift 5.", onboardingItems: [
            OnboardItemView.Properties(content: "View tutorials on over 50 computer science algorithms, as well as implementations.", icon: UIImage(named: "algo")),
            OnboardItemView.Properties(content: "Check out examples of arrays, queues, lists, trees and hashes implemented in Swift!", icon: UIImage(named: "data_structure")),
            OnboardItemView.Properties(content: "Sourced from Raywenderlich.com's Algorithm Club, these Markdown resources are fetched from the github repository.", icon: UIImage(named: "math")),
            ])
    }
}

