import Foundation

public enum GettingStartedAlgorithm: CaseIterable, SortingAlgorithmable {
    case stack
    case queue
    case insertionSort
    case binarySearch
    case binarySearchTree
    case mergeSort
    case boyerMoore
}

extension GettingStartedAlgorithm: Algorithm {
    
    public var category: AlgorithmCategory {
        return .gettingStarted
    }

    public var title: String {
        switch self {            
        case .stack:
            return "Stack"
        case .queue:
            return "Queue"
        case .insertionSort:
            return "Insertion Sort"
        case .binarySearch:
            return "Binary Search"
        case .binarySearchTree:
            return "Binary Search Tree"
        case .mergeSort:
            return "Merge Sort"
        case .boyerMoore:
            return "Boyer Moore"
        }
    }
    
    public var subtitle: String? {
        return nil
    }
    
    public var resourceUrl: String {
        switch self {
            
        case .stack:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Stack/README.markdown"
        case .queue:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Queue/README.markdown"
        case .insertionSort:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Insertion%20Sort/README.markdown"
        case .binarySearch:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Binary%20Search/README.markdown"
        case .binarySearchTree:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Binary%20Search%20Tree/README.markdown"
        case .mergeSort:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Merge%20Sort/README.markdown"
        case .boyerMoore:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Boyer-Moore-Horspool/README.markdown"
        }
    }
}
