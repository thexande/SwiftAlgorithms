import UIKit

protocol NavigationConfigurable {
    var actionImage: UIImage? { get }
}

enum IntroductionAlgorithm: CaseIterable {
    case whatAreAlgorithms
    case whyLearnAlgorithms
    case bigO
    case designTechniques
    case howToContribute
}

extension IntroductionAlgorithm: NavigationConfigurable {
    var actionImage: UIImage? {
        switch self {
        case .whatAreAlgorithms:
            return UIImage(named: "pancakes")
        case .whyLearnAlgorithms:
            return UIImage(named: "?")
        case .bigO:
            return UIImage(named: "line_chart")
        case .designTechniques:
            return UIImage(named: "algo")
        case .howToContribute:
            return UIImage(named: "git")
        }
    }
}

extension IntroductionAlgorithm: Algorithm {
    
    var category: AlgorithmCategory {
        return .gettingStarted
    }
    
    var navTitle: String {
        switch self {
        case .whatAreAlgorithms:
            return "Pancakes!"
        case .whyLearnAlgorithms:
            return "Why Learn?"
        case .bigO:
            return "Big O"
        case .designTechniques:
            return "Design Techniques"
        case .howToContribute:
            return "How To Contribute"
        }
    }
    
    var title: String {
        switch self {
        case .whatAreAlgorithms:
            return "What are algorithms and data structures?"
        case .whyLearnAlgorithms: return
            "Why learn algorithms?"
        case .bigO:
            return "Big-O notation"
        case .designTechniques:
            return "Algorithm design techniques"
        case .howToContribute:
            return "How to contribute"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .whatAreAlgorithms:
            return "Pancakes!"
        case .whyLearnAlgorithms:
            return "Worried this isn't your cup of tea? Then read this."
        case .bigO:
            return "We often say things like, 'This algorithm is O(n).' If you don't know what that means, read this first."
        case .designTechniques:
            return "How do you create your own algorithms?"
        case .howToContribute:
            return "Report an issue to leave feedback, or submit a pull request."
        }
    }
    
    var resourceUrl: String {
        switch self {
        case .whatAreAlgorithms:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/What%20are%20Algorithms.markdown"
        case .whyLearnAlgorithms:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Why%20Algorithms.markdown"
        case .bigO:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Big-O%20Notation.markdown"
        case .designTechniques:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Algorithm%20Design.markdown"
        case .howToContribute:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/.github/CONTRIBUTING.md"
        }
    }
}




