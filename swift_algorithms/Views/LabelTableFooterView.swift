import UIKit
import Anchorage

final class AboutView: UIView {
    let title = UILabel()
    let content = UILabel()
    let icon = UIImageView()
    let labelStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        icon.image = UIImage(named: "swift_algo_club")
        addSubview(icon)
        icon.sizeAnchors == CGSize(width: 200, height: 200)
        icon.centerXAnchor == centerXAnchor
        icon.topAnchor == topAnchor + 36
        
        let labels = [title, content]
        labels.forEach { label in
            label.numberOfLines = 0
            labelStack.addArrangedSubview(label)
        }
        
        labelStack.spacing = 18
        labelStack.axis = .vertical
        addSubview(labelStack)
        labelStack.topAnchor == icon.bottomAnchor + 36
        labelStack.horizontalAnchors == horizontalAnchors + 18
        labelStack.bottomAnchor == bottomAnchor - 18
        
        title.text = "Welcome to the Swift Algorithm Club!"
        content.text = """
        Here you'll find implementations of popular algorithms and data structures in everyone's favorite new language Swift, with detailed explanations of how they work.
        
        If you're a computer science student who needs to learn this stuff for exams -- or if you're a self-taught programmer who wants to brush up on the theory behind your craft -- you've come to the right place!
        
        The goal of this project is to explain how algorithms work. The focus is on clarity and readability of the code, not on making a reusable library that you can drop into your own projects. That said, most of the code should be ready for production use but you may need to tweak it to fit into your own codebase.
        
        Code is compatible with Xcode 9 and Swift 4. We'll keep this updated with the latest version of Swift.
        
        😍 Suggestions and contributions are welcome! 😍
        """
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
