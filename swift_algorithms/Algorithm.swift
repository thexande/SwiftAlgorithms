import UIKit

enum Algorithm {
    case whatAreAlgorithms
    case whyLearnAlgorithms
    case bigO
    case designTechniques
    case howToContribute
    
    // getting started
    
    case stack
    case queue
    case insertionSort
    case binarySearch
    case binarySearchTree
    case mergeSort
    case boyerMoore
    
    // Searching
    
    case linnearSearch
    case countOccurences
    case selectMinMax
    case kthLargestElement
    case selectionSampling
    case unionFind
    
    // String Search
    
    case bruteForceStringSearch
    case knuthMorrisPratt
    case rabinKarp
    case longestCommonSubsequence
    case zAlgorithm
    
    // Sorting
    
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
    
    // Compression
    
    case runLengthEncoding
    case huffmanCoding
    
    // Miscellaneous
    
    case shuffle
    case comboSort
    case convexHull
    case millerRabin
    case minimumCoin
    
    // Mathematics
    
    case gcd
    case permutationsAndCombinations
    case shuntingYard
    case karatsubaMultiplication
    case haversineDistance
    case strassenMultiplicationMatrix
    
    // Machine Learning
    
    case kMeansClustering
    case linnearRegression
    case naiveBayesClassifier
    case simulatedAnnealing
    
    var title: String {
        switch self {
        case .whatAreAlgorithms: return "Pancakes!"
        case .whyLearnAlgorithms: return "Why Learn?"
        case .bigO: return "Big O"
        case .designTechniques: return "Design Techniques"
        case .howToContribute: return "How To Contribute"
            
            // getting started
            
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
            
            // Searching
            
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
            
            // String Search
            
        case .bruteForceStringSearch:
            return "Brute Force String Search"
        case .knuthMorrisPratt:
            return "Knuth Morris Pratt"
        case .rabinKarp:
            return "Rabin Karp"
        case .longestCommonSubsequence:
            return "Longest Common Subsequence"
        case .zAlgorithm:
            return "Z Algorithm"
            
            // Sorting
            
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
            
            // Compression
            
        case .runLengthEncoding:
            return "Run Length Encoding"
        case .huffmanCoding:
            return "Huffman Coding"
            
            // Miscellaneous
            
        case .shuffle:
            return "Shuffle"
        case .comboSort:
            return "Combo Sort"
        case .convexHull:
            return "Convex Hull"
        case .millerRabin:
            return "Miller Rabin"
        case .minimumCoin:
            return "Minimum Coin"
            
            // Mathematics
            
        case .gcd:
            return "Greatest Common Denominator"
        case .permutationsAndCombinations:
            return "Permutations & Combinations"
        case .shuntingYard:
            return "Shunning Yard"
        case .karatsubaMultiplication:
            return "Karatsuba Multiplication"
        case .haversineDistance:
            return "Haversine Distance"
        case .strassenMultiplicationMatrix:
            return "Strassen Multiplication Matrix"
            
            // Machine Learning
            
        case .kMeansClustering:
            return "K Means Clustering"
        case .linnearRegression:
            return "Linnear Regression"
        case .naiveBayesClassifier:
            return "Naive Bayes Classifier"
        case .simulatedAnnealing:
            return "Simulated Annealing"
        }
    }
    
    static func category(for action: Algorithm) -> Algorithm.Category? {
        switch action {
            
        // getting started
        case .stack, .queue, .insertionSort, .binarySearch, .binarySearchTree, .mergeSort, .boyerMoore:
            return .gettingStarted
            
        // Searching
        case .linnearSearch, .countOccurences, .selectMinMax, .kthLargestElement, .selectionSampling, .unionFind:
            return .searching
            
        // String Search
        case .bruteForceStringSearch, .knuthMorrisPratt, .rabinKarp, .longestCommonSubsequence, .zAlgorithm:
            return .stringSearch
            
        // Sorting
        case .selectionSort, .shellSort, .quickSort, .heapSort, .introSort, .countingSort, .radixSort, .topologicalSort, .bubbleSort, .slowSort:
            return .sorting
            
        // Compression
        case .runLengthEncoding, .huffmanCoding:
            return .compression
            
        // Miscellaneous
        case .shuffle, .comboSort, .convexHull, .millerRabin, .minimumCoin:
            return .misc
            
        // Mathematics
        case .gcd, .permutationsAndCombinations, .shuntingYard, .karatsubaMultiplication, .haversineDistance, .strassenMultiplicationMatrix:
            return .math
            
        // Machine Learning
        case .kMeansClustering, .linnearRegression, .naiveBayesClassifier, .simulatedAnnealing:
            return .machineLearning
            
        default:
            return nil
        }
    }
    
    
    enum Category {
        case gettingStarted
        case searching
        case stringSearch
        case sorting
        case compression
        case misc
        case math
        case machineLearning
        
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
        
        var color: UIColor {
            switch self {
            case .gettingStarted:
                return .coral()
            case .searching:
                return .newGreen()
            case .stringSearch:
                return UIColor.amethist()
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
    
    var category: Algorithm.Category? {
        return Algorithm.category(for: self)
    }
    
}
