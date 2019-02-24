enum MiscAlgorithm: CaseIterable {
    case shuffle
    case comboSort
    case convexHull
    case millerRabin
    case minimumCoin
}

extension MiscAlgorithm: Algorithm {
    
    var category: AlgorithmCategory {
        return .misc
    }
    
    var title: String {
        switch self {
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
        }
    }
    
    var subtitle: String? {
        switch self {
        case .shuffle:
            return "Randomly rearranges the contents of an array."
        case .comboSort:
            return "An improve upon the Bubble Sort algorithm."
        case .convexHull:
            return "The Convex Hull algorithm calculates the shape (made up from the points itself) containing all these points."
        case .millerRabin:
            return "Is the number a prime number?"
        case .minimumCoin:
            return "A showcase for dynamic programming."
        }
    }
    
    var resourceUrl: String {
        switch self {
            
        case .shuffle:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Shuffle/README.markdown"
        case .comboSort:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Comb%20Sort/README.markdown"
        case .convexHull:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Convex%20Hull/README.md"
        case .millerRabin:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Miller-Rabin%20Primality%20Test/README.markdown"
        case .minimumCoin:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/MinimumCoinChange/README.md"
        }
    }
}
