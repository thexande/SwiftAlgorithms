import Foundation

public protocol SortingAlgorithmable: Algorithm { }

public enum SortingLevel: CaseIterable {
    case basic
    case fast
    case hybrid
    case specialPurpose
    case bad
}

public extension SortingLevel {
    
    var title: String {
        switch self {
        case .basic:
            return "Basic"
        case .fast:
            return "Fast"
        case .hybrid:
            return "Hybrid"
        case .specialPurpose:
            return "Special Purpose"
        case .bad:
            return "Bad"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .basic:
            return  "It's fun to see how sorting algorithms work, but in practice you'll almost never have to provide your own sorting routines. Swift's own sort() is more than up to the job. But if you're curious, read on..."
        default:
            return nil
        }
    }
    
    var algorithms: [SortingAlgorithmable] {
        switch self {
        case .basic:
            return [GettingStartedAlgorithm.insertionSort, SortingAlgorithm.selectionSort, SortingAlgorithm.shellSort]
        case .fast:
            return [SortingAlgorithm.quickSort, GettingStartedAlgorithm.mergeSort, SortingAlgorithm.heapSort]
        case .hybrid:
            return [SortingAlgorithm.introSort]
        case .specialPurpose:
            return [SortingAlgorithm.countingSort, SortingAlgorithm.radixSort, SortingAlgorithm.topologicalSort]
        case .bad:
            return [SortingAlgorithm.bubbleSort, SortingAlgorithm.slowSort]
        }
    }

}
