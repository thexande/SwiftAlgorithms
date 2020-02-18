public enum MachineLearningAlgorithm: CaseIterable {
    case kMeansClustering
    case linnearRegression
    case naiveBayesClassifier
    case simulatedAnnealing
}

extension MachineLearningAlgorithm: Algorithm {
    
    public var category: AlgorithmCategory {
        return .machineLearning
    }
    
    public var subtitle: String? {
        switch self {
        case .kMeansClustering:
            return "Unsupervised classifier that partitions data into k clusters"
        case .linnearRegression:
            return "A technique for creating a model of the relationship between two (or more) variable quantities."
        case .naiveBayesClassifier:
            return "The goal of a classifier is to predict the class of a given data entry based on previously fed data and its features."
        case .simulatedAnnealing:
            return "Probabilistic technique for approximating the global maxima in a (often discrete) large search space."
        }
    }
    
    public var title: String {
        switch self {
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
    
    public var resourceUrl: String {
        switch self {
        case .kMeansClustering:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/K-Means/README.markdown"
        case .linnearRegression:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Linear%20Regression/README.markdown"
        case .naiveBayesClassifier:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Naive%20Bayes%20Classifier/README.md"
        case .simulatedAnnealing:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Simulated%20annealing/README.md"
        }
    }
}
