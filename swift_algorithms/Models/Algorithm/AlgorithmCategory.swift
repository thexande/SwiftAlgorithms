import UIKit

enum AlgorithmCategory: CaseIterable {
    case gettingStarted
    case searching
    case stringSearch
    case sorting
    case compression
    case misc
    case math
    case machineLearning
}

extension AlgorithmCategory {
    
    var title: String {
        switch self {
        case .gettingStarted:
            return "Getting Started"
        case .searching:
            return "Searching"
        case .stringSearch:
            return "String Search"
        case .sorting:
            return "Sorting"
        case .compression:
            return "Compression"
        case .misc:
            return "Miscellaneous"
        case .math:
            return "Math"
        case .machineLearning:
            return "Machine Learning"
        }
    }
    
    var sectionSubtitle: String? {
        switch self {
        case .gettingStarted:
            return "If you're new to algorithms and data structures, here are a few good ones to start out with:"
        case .searching:
            return nil
        case .stringSearch:
            return nil
        case .sorting:
            return  "It's fun to see how sorting algorithms work, but in practice you'll almost never have to provide your own sorting routines. Swift's own sort() is more than up to the job. But if you're curious, read on..."
        case .compression, .misc, .math, .machineLearning:
            return nil
        }
    }
    
    var color: UIColor {
        switch self {
        case .gettingStarted:
            return .coral()
        case .searching:
            return .newGreen()
        case .stringSearch:
            return .amethist()
        case .sorting:
            return .newOrange()
        case .compression:
            return .newPink()
        case .misc:
            return .newBlue()
        case .math:
            return .newYellow()
        case .machineLearning:
            return .newLightBlue()
        }
    }
    
    var image: UIImage? {
        switch self {
        case .gettingStarted:
            return UIImage(named: "start")
        case .searching:
            return UIImage(named: "search")
        case .stringSearch:
            return UIImage(named: "search")
        case .sorting:
            return UIImage(named: "filter")
        case .compression:
            return UIImage(named: "zip")
        case .misc:
            return UIImage(named: "misc")
        case .math:
            return UIImage(named: "math")
        case .machineLearning:
            return UIImage(named: "pcb")
        }
    }
}
