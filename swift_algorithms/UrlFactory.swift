import Foundation

final class UrlFactory {
    func markdownFileUrl(for algorithmAction: AlgorithmViewController.Action) -> URL? {
        switch algorithmAction {
        case .whatAreAlgorithms:
            return URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/What%20are%20Algorithms.markdown")
        case .whyLearnAlgorithms:
            return nil
        case .bigO:
            return nil
        case .designTechniques:
            return nil
        case .howToContribute:
            return nil
            
        case .stack:
            return nil
        case .queue:
            return nil
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
