//import UIKit
//
//protocol AlgorithmCategory {
//    var title: String { get }
//    var subtitle: String? { get }
//}
//
//protocol EnumCollection : Hashable {}
//
//
//extension EnumCollection {
//    
//    static func cases() -> AnySequence<Self> {
//        typealias S = Self
//        return AnySequence { () -> AnyIterator<S> in
//            var raw = 0
//            return AnyIterator {
//                let current : Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: S.self, capacity: 1) { $0.pointee }
//                }
//                guard current.hashValue == raw else { return nil }
//                raw += 1
//                return current
//            }
//        }
//    }
//}
//
//struct Algorithm {
//    
//    let categories: [AlgorithmCategory] = [
//        Informational,
//        GettingStarted,
//        Searching,
//        StringSearch,
//        Compression,
//        Miscellaneous,
//        Mathematics,
//        MachineLearning
//    ]
//    
//    // Informational
//    
//    //    static func category(for action: Algorithm) -> Algorithm.Category? {
//    //        switch action {
//    //
//    //        // getting started
//    //        case .stack, .queue, .insertionSort, .binarySearch, .binarySearchTree, .mergeSort, .boyerMoore:
//    //            return .gettingStarted
//    //
//    //        // Searching
//    //        case .linnearSearch, .countOccurences, .selectMinMax, .kthLargestElement, .selectionSampling, .unionFind:
//    //            return .searching
//    //
//    //        // String Search
//    //        case .bruteForceStringSearch, .knuthMorrisPratt, .rabinKarp, .longestCommonSubsequence, .zAlgorithm:
//    //            return .stringSearch
//    //
//    //        // Sorting
//    //        case .selectionSort, .shellSort, .quickSort, .heapSort, .introSort, .countingSort, .radixSort, .topologicalSort, .bubbleSort, .slowSort:
//    //            return .sorting
//    //
//    //        // Compression
//    //        case .runLengthEncoding, .huffmanCoding:
//    //            return .compression
//    //
//    //        // Miscellaneous
//    //        case .shuffle, .comboSort, .convexHull, .millerRabin, .minimumCoin:
//    //            return .misc
//    //
//    //        // Mathematics
//    //        case .gcd, .permutationsAndCombinations, .shuntingYard, .karatsubaMultiplication, .haversineDistance, .strassenMultiplicationMatrix:
//    //            return .math
//    //
//    //        // Machine Learning
//    //        case .kMeansClustering, .linnearRegression, .naiveBayesClassifier, .simulatedAnnealing:
//    //            return .machineLearning
//    //
//    //        default:
//    //            return nil
//    //        }
//    //    }
//    
//    enum Informational: AlgorithmCategory, EnumCollection {
//        
//        case whatAreAlgorithms
//        case whyLearnAlgorithms
//        case bigO
//        case designTechniques
//        case howToContribute
//        
//        var title: String {
//            switch self {
//            case .whatAreAlgorithms:
//                return "Pancakes!"
//            case .whyLearnAlgorithms:
//                return "Why Learn?"
//            case .bigO:
//                return "Big O"
//            case .designTechniques:
//                return "Design Techniques"
//            case .howToContribute:
//                return "How To Contribute"
//            }
//        }
//        
//        var subtitle: String? {
//            switch self {
//            case .whatAreAlgorithms:
//                return ""
//            case .whyLearnAlgorithms:
//                return ""
//            case .bigO:
//                return ""
//            case .designTechniques:
//                return "Design Techniques"
//            case .howToContribute:
//                return ""
//            }
//        }
//    }
//    
//    // getting started
//    
//    enum GettingStarted: AlgorithmCategory, EnumCollection {
//        
//        case stack
//        case queue
//        case insertionSort
//        case binarySearch
//        case binarySearchTree
//        case mergeSort
//        case boyerMoore
//        
//        public var title: String {
//            switch self {
//            case .stack:
//                return "Stack"
//            case .queue:
//                return "Queue"
//            case .insertionSort:
//                return "Insertion Sort"
//            case .binarySearch:
//                return "Binary Search"
//            case .binarySearchTree:
//                return "Binary Search Tree"
//            case .mergeSort:
//                return "Merge Sort"
//            case .boyerMoore:
//                return "Boyer Moore"
//            }
//        }
//        
//        public var subtitle: String? {
//            switch self {
//            case .stack:
//                return ""
//            case .queue:
//                return ""
//            case .insertionSort:
//                return ""
//            case .binarySearch:
//                return ""
//            case .binarySearchTree:
//                return ""
//            case .mergeSort:
//                return ""
//            case .boyerMoore:
//                return ""
//            }
//        }
//    }
//    
//    // Searching
//    
//    
//    enum Searching: AlgorithmCategory, EnumCollection {
//        
//        case linnearSearch
//        case countOccurences
//        case selectMinMax
//        case kthLargestElement
//        case selectionSampling
//        case unionFind
//        
//        public var title: String {
//            switch self {
//            case .linnearSearch:
//                return "Linnear Search"
//            case .countOccurences:
//                return "Count Occurences"
//            case .selectMinMax:
//                return "Select Min / Max"
//            case .kthLargestElement:
//                return "Kth Largest Element"
//            case .selectionSampling:
//                return "Selection Sampling"
//            case .unionFind:
//                return "Union Find"
//            }
//        }
//        
//        public var subtitle: String? {
//            switch self {
//            case .linnearSearch:
//                return ""
//            case .countOccurences:
//                return ""
//            case .selectMinMax:
//                return ""
//            case .kthLargestElement:
//                return ""
//            case .selectionSampling:
//                return ""
//            case .unionFind:
//                return ""
//            }
//        }
//    }
//    
//    // String Search
//    
//    enum StringSearch: AlgorithmCategory, EnumCollection {
//        
//        case bruteForceStringSearch
//        case knuthMorrisPratt
//        case rabinKarp
//        case longestCommonSubsequence
//        case zAlgorithm
//        
//        public var title: String {
//            switch self {
//            case .bruteForceStringSearch:
//                return "Brute Force String Search"
//            case .knuthMorrisPratt:
//                return "Knuth Morris Pratt"
//            case .rabinKarp:
//                return "Rabin Karp"
//            case .longestCommonSubsequence:
//                return "Longest Common Subsequence"
//            case .zAlgorithm:
//                return "Z Algorithm"
//            }
//        }
//        
//        public var subtitle: String? {
//            switch self {
//            case .bruteForceStringSearch:
//                return ""
//            case .knuthMorrisPratt:
//                return ""
//            case .rabinKarp:
//                return ""
//            case .longestCommonSubsequence:
//                return ""
//            case .zAlgorithm:
//                return ""
//            }
//        }
//    }
//    
//    // Sorting
//    
//    enum Sorting: AlgorithmCategory, EnumCollection {
//        
//        case selectionSort
//        case shellSort
//        case quickSort
//        case heapSort
//        case introSort
//        case countingSort
//        case radixSort
//        case topologicalSort
//        case bubbleSort
//        case slowSort
//        
//        public var title: String {
//            switch self {
//            case .selectionSort:
//                return "Selection Sort"
//            case .shellSort:
//                return "Shell Sort"
//            case .quickSort:
//                return "Quick Sort"
//            case .heapSort:
//                return "Heap Sort"
//            case .introSort:
//                return "Intro Sort"
//            case .countingSort:
//                return "Counting Sort"
//            case .radixSort:
//                return "Radix Sort"
//            case .topologicalSort:
//                return "Topological Sort"
//            case .bubbleSort:
//                return "Bubble Sort"
//            case .slowSort:
//                return "Slow Sort"
//            }
//        }
//        
//        public var subtitle: String? {
//            switch self {
//            case .selectionSort:
//                return ""
//            case .shellSort:
//                return ""
//            case .quickSort:
//                return ""
//            case .heapSort:
//                return ""
//            case .introSort:
//                return ""
//            case .countingSort:
//                return ""
//            case .radixSort:
//                return ""
//            case .topologicalSort:
//                return ""
//            case .bubbleSort:
//                return ""
//            case .slowSort:
//                return ""
//            }
//        }
//    }
//    
//    // Compression
//    
//    enum Compression: AlgorithmCategory, EnumCollection {
//        
//        case runLengthEncoding
//        case huffmanCoding
//        
//        public var title: String {
//            switch self {
//            case .runLengthEncoding:
//                return "Run Length Encoding"
//            case .huffmanCoding:
//                return "Huffman Coding"
//            }
//        }
//        
//        public var subtitle: String? {
//            switch self {
//            case .runLengthEncoding:
//                return ""
//            case .huffmanCoding:
//                return ""
//            }
//        }
//    }
//    
//    // Miscellaneous
//    
//    enum Miscellaneous: AlgorithmCategory, EnumCollection {
//        
//        case shuffle
//        case comboSort
//        case convexHull
//        case millerRabin
//        case minimumCoin
//        
//        public var title: String {
//            switch self {
//            case .shuffle:
//                return "Shuffle"
//            case .comboSort:
//                return "Combo Sort"
//            case .convexHull:
//                return "Convex Hull"
//            case .millerRabin:
//                return "Miller Rabin"
//            case .minimumCoin:
//                return "Minimum Coin"
//            }
//        }
//        
//        public var subtitle: String? {
//            switch self {
//            case .shuffle:
//                return ""
//            case .comboSort:
//                return ""
//            case .convexHull:
//                return ""
//            case .millerRabin:
//                return ""
//            case .minimumCoin:
//                return ""
//            }
//        }
//    }
//    
//    // Mathematics
//    
//    enum Mathematics: AlgorithmCategory, EnumCollection {
//        
//        case gcd
//        case permutationsAndCombinations
//        case shuntingYard
//        case karatsubaMultiplication
//        case haversineDistance
//        case strassenMultiplicationMatrix
//        
//        public var title: String {
//            switch self {
//            case .gcd:
//                return "Greatest Common Denominator"
//            case .permutationsAndCombinations:
//                return "Permutations & Combinations"
//            case .shuntingYard:
//                return "Shunning Yard"
//            case .karatsubaMultiplication:
//                return "Karatsuba Multiplication"
//            case .haversineDistance:
//                return "Haversine Distance"
//            case .strassenMultiplicationMatrix:
//                return "Strassen Multiplication Matrix"
//                
//            }
//        }
//        
//        public var subtitle: String? {
//            switch self {
//            case .gcd:
//                return ""
//            case .permutationsAndCombinations:
//                return ""
//            case .shuntingYard:
//                return ""
//            case .karatsubaMultiplication:
//                return ""
//            case .haversineDistance:
//                return ""
//            case .strassenMultiplicationMatrix:
//                return ""
//            }
//        }
//    }
//    
//    // Machine Learning
//    
//    enum MachineLearning: AlgorithmCategory, EnumCollection {
//        case kMeansClustering
//        case linnearRegression
//        case naiveBayesClassifier
//        case simulatedAnnealing
//        
//        public var title: String {
//            switch self {
//            case .kMeansClustering:
//                return "K Means Clustering"
//            case .linnearRegression:
//                return "Linnear Regression"
//            case .naiveBayesClassifier:
//                return "Naive Bayes Classifier"
//            case .simulatedAnnealing:
//                return "Simulated Annealing"
//            }
//        }
//        
//        public var subtitle: String? {
//            switch self {
//            case .kMeansClustering:
//                return ""
//            case .linnearRegression:
//                return ""
//            case .naiveBayesClassifier:
//                return ""
//            case .simulatedAnnealing:
//                return ""
//            }
//        }
//    }
//}
