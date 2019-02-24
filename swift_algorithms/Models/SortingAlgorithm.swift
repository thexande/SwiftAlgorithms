enum SortingAlgorithm: CaseIterable {
    case selectionSort
    case shellSort
    case quickSort
    case heapSort
    case introSort
    case countingSort
    case radixSort
    case topologicalSort
    case bubbleSort
    case slowSort
}

extension SortingAlgorithm: Algorithm, SortingAlgorithmable {
    
    var category: AlgorithmCategory {
        return .sorting
    }
    
    var title: String {
        switch self {
        case .selectionSort:
            return "Selection Sort"
        case .shellSort:
            return "Shell Sort"
        case .quickSort:
            return "Quick Sort"
        case .heapSort:
            return "Heap Sort"
        case .introSort:
            return "Intro Sort"
        case .countingSort:
            return "Counting Sort"
        case .radixSort:
            return "Radix Sort"
        case .topologicalSort:
            return "Topological Sort"
        case .bubbleSort:
            return "Bubble Sort"
        case .slowSort:
            return "Slow Sort"
        }
    }
    
    var subtitle: String? {
        return nil
    }
    
    var resourceUrl: String {
        switch self {
        case .selectionSort:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Selection%20Sort/README.markdown"
        case .shellSort:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Shell%20Sort/README.markdown"
        case .quickSort:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Quicksort/README.markdown"
        case .heapSort:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Heap%20Sort/README.markdown"
            
        case .introSort:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Introsort/README.markdown"
            
        case .countingSort:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Counting%20Sort/README.markdown"
        case .radixSort:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Radix%20Sort/ReadMe.md"
        case .topologicalSort:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Topological%20Sort/README.markdown"
            
        case .bubbleSort:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Bubble%20Sort/README.markdown"
        case .slowSort:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Slow%20Sort/README.markdown"
        }
    }
}
