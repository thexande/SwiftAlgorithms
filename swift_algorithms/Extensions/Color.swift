import SwiftAlgorithmsDataLayer
import SwiftAlgorithmsUserInterface

extension AlgorithmCategory {
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
}

extension DataStructure.Category {
    var color: UIColor {
        switch self {
        case .array:
            return .amethist()
        case .queue:
            return .newBlue()
        case .list:
            return .coral()
        case .tree:
            return .newYellow()
        case .hash:
            return .newGreen()
        case .set:
            return .newLightBlue()
        case .graph:
            return .newPink()
        }
    }
}
