import Foundation

final class UrlFactory {
    func markdownFileUrl(for algorithmAction: AlgorithmViewController.Action) -> URL? {
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
            return nil
        case .binarySearch:
            return nil
        case .binarySearchTree:
            return nil
        case .mergeSort:
            return nil
        case .boyerMoore:
            return nil
            
        case .linnearSearch:
            return nil
        case .countOccurences:
            return nil
        case .selectMinMax:
            return nil
        case .kthLargestElement:
            return nil
        case .selectionSampling:
            return nil
        case .unionFind:
            return nil
        case .bruteForceStringSearch:
            return nil
        case .knuthMorrisPratt:
            return nil
        case .rabinKarp:
            return nil
        case .longestCommonSubsequence:
            return nil
        case .zAlgorithm:
            return nil
        case .selectionSort:
            return nil
        case .shellSort:
            return nil
        case .quickSort:
            return nil
        case .heapSort:
            return nil
        case .introSort:
            return nil
        case .countingSort:
            return nil
        case .radixSort:
            return nil
        case .topologicalSort:
            return nil
        case .bubbleSort:
            return nil
        case .slowSort:
            return nil
        case .runLengthEncoding:
            return nil
        case .huffmanCoding:
            return nil
        case .shuffle:
            return nil
        case .comboSort:
            return nil
        case .convexHull:
            return nil
        case .millerRabin:
            return nil
        case .minimumCoin:
            return nil
        case .gcd:
            return nil
        case .permutationsAndCombinations:
            return nil
        case .shuntingYard:
            return nil
        case .karatsubaMultiplication:
            return nil
        case .haversineDistance:
            return nil
        case .strassenMultiplicationMatrix:
            return nil
        case .kMeansClustering:
            return nil
        case .linnearRegression:
            return nil
        case .naiveBayesClassifier:
            return nil
        case .simulatedAnnealing:
            return nil
        }
    }
}
