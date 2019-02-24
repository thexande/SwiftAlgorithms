enum SearchingAlgorithm: CaseIterable {
    case linnearSearch
    case countOccurences
    case selectMinMax
    case kthLargestElement
    case selectionSampling
    case unionFind
}

extension SearchingAlgorithm: Algorithm {
    
    var category: AlgorithmCategory {
        return .searching
    }
    
    var title: String {
        switch self {
        case .linnearSearch:
            return "Linnear Search"
        case .countOccurences:
            return "Count Occurences"
        case .selectMinMax:
            return "Select Min / Max"
        case .kthLargestElement:
            return "Kth Largest Element"
        case .selectionSampling:
            return "Selection Sampling"
        case .unionFind:
            return "Union Find"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .linnearSearch:
            return "Find an element in an array."
        case .countOccurences:
            return "Count how often a value appears in an array."
        case .selectMinMax:
            return "Find the minimum/maximum value in an array."
        case .kthLargestElement:
            return "Find the k-th largest element in an array, such as the median."
        case .selectionSampling:
            return "Randomly choose a bunch of items from a collection."
        case .unionFind:
            return "Keeps track of disjoint sets and lets you quickly merge them."
        }
    }
    
    var resourceUrl: String {
        switch self {
        case .linnearSearch:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Linear%20Search/README.markdown"
        case .countOccurences:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Count%20Occurrences/README.markdown"
        case .selectMinMax:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Select%20Minimum%20Maximum/README.markdown"
        case .kthLargestElement:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Kth%20Largest%20Element/README.markdown"
        case .selectionSampling:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Selection%20Sampling/README.markdown"
        case .unionFind:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Union-Find/README.markdown"
        }
    }
}
