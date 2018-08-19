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
        }
    }
}
