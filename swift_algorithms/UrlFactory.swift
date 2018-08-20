import Foundation

final class UrlFactory {
    func markdownFileUrl(for algorithmAction: Algorithm) -> URL? {
        switch algorithmAction {
        case .whatAreAlgorithms:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/What%20are%20Algorithms.markdown")
        case .whyLearnAlgorithms:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Why%20Algorithms.markdown")
        case .bigO:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Big-O%20Notation.markdown")
        case .designTechniques:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Algorithm%20Design.markdown")
        case .howToContribute:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/.github/CONTRIBUTING.md")
            
        case .stack:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Stack/README.markdown")
        case .queue:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Queue/README.markdown")
        case .insertionSort:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Insertion%20Sort/README.markdown")
        case .binarySearch:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Binary%20Search/README.markdown")
        case .binarySearchTree:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Binary%20Search%20Tree/README.markdown")
        case .mergeSort:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Merge%20Sort/README.markdown")
        case .boyerMoore:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Boyer-Moore-Horspool/README.markdown")
            
        case .linnearSearch:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Linear%20Search/README.markdown")
        case .countOccurences:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Count%20Occurrences/README.markdown")
        case .selectMinMax:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Select%20Minimum%20Maximum/README.markdown")
        case .kthLargestElement:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Kth%20Largest%20Element/README.markdown")
        case .selectionSampling:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Selection%20Sampling/README.markdown")
        case .unionFind:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Union-Find/README.markdown")
        
        case .bruteForceStringSearch:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Brute-Force%20String%20Search/README.markdown")
        case .knuthMorrisPratt:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Knuth-Morris-Pratt/README.markdown")
        case .rabinKarp:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Rabin-Karp/README.markdown")
        case .longestCommonSubsequence:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Longest%20Common%20Subsequence/README.markdown")
        case .zAlgorithm:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Z-Algorithm/README.markdown")
        
            // missing?
        case .selectionSort:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Selection%20Sort/README.markdown")
        case .shellSort:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Shell%20Sort/README.markdown")
        case .quickSort:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Quicksort/README.markdown")
        case .heapSort:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Heap%20Sort/README.markdown")
            
        case .introSort:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Introsort/README.markdown")
            
        case .countingSort:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Counting%20Sort/README.markdown")
        case .radixSort:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Radix%20Sort/ReadMe.md")
        case .topologicalSort:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Topological%20Sort/README.markdown")
       
        case .bubbleSort:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Bubble%20Sort/README.markdown")
        case .slowSort:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Slow%20Sort/README.markdown")
            
        case .runLengthEncoding:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Run-Length%20Encoding/README.markdown")
        case .huffmanCoding:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Huffman%20Coding/README.markdown")
            
        case .shuffle:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Shuffle/README.markdown")
        case .comboSort:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Comb%20Sort/README.markdown")
        case .convexHull:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Convex%20Hull/README.md")
        case .millerRabin:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Miller-Rabin%20Primality%20Test/README.markdown")
        case .minimumCoin:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/MinimumCoinChange/README.md")
            
        case .gcd:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/GCD/README.markdown")
        case .permutationsAndCombinations:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Combinatorics/README.markdown")
        case .shuntingYard:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Shunting%20Yard/README.markdown")
        case .karatsubaMultiplication:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Karatsuba%20Multiplication/README.markdown")
        case .haversineDistance:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/HaversineDistance/README.md")
        case .strassenMultiplicationMatrix:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Strassen%20Matrix%20Multiplication/README.markdown")
            
        case .kMeansClustering:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/K-Means/README.markdown")
        case .linnearRegression:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Linear%20Regression/README.markdown")
        case .naiveBayesClassifier:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Naive%20Bayes%20Classifier/README.md")
        case .simulatedAnnealing:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Simulated%20annealing/README.md")
        }
    }
}
