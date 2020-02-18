import UIKit

public protocol Algorithm {
    var category: AlgorithmCategory { get }
    var title: String { get }
    var subtitle: String? { get }
    var resourceUrl: String { get }
    var navTitle: String { get }
}

extension Algorithm {
    public var navTitle: String {
        return self.title
    }
}

public struct AlgorithmType {
    public static func allCases() -> [Algorithm] {
        var allCases: [Algorithm] = []
        
        allCases.append(contentsOf: IntroductionAlgorithm.allCases as [Algorithm])
        allCases.append(contentsOf: GettingStartedAlgorithm.allCases as [Algorithm])
        allCases.append(contentsOf: SearchingAlgorithm.allCases as [Algorithm])
        allCases.append(contentsOf: StringSearchAlgorithm.allCases as [Algorithm])
        allCases.append(contentsOf: SortingAlgorithm.allCases as [Algorithm])
        allCases.append(contentsOf: CompressionAlgorithm.allCases as [Algorithm])
        allCases.append(contentsOf: MiscAlgorithm.allCases as [Algorithm])
        allCases.append(contentsOf: MiscAlgorithm.allCases as [Algorithm])
        allCases.append(contentsOf: MachineLearningAlgorithm.allCases as [Algorithm])
        return allCases
    }
}
