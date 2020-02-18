public enum StringSearchAlgorithm: CaseIterable {
    case bruteForceStringSearch
    case knuthMorrisPratt
    case rabinKarp
    case longestCommonSubsequence
    case zAlgorithm
}

extension StringSearchAlgorithm: Algorithm {
    
    public var category: AlgorithmCategory {
        return .stringSearch
    }
    
    public var title: String {
        switch self {
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
        }
    }
    
    public var subtitle: String? {
        switch self {
        case .bruteForceStringSearch:
            return "A naive method"
        case .knuthMorrisPratt:
            return "A linear-time string algorithm that returns indexes of all occurrencies of a given pattern."
        case .rabinKarp:
            return "Faster search by using hashing."
        case .longestCommonSubsequence:
            return "Find the longest sequence of characters that appear in the same order in both strings."
        case .zAlgorithm:
            return "Finds all instances of a pattern in a String, and returns the indexes of where the pattern starts within the String."
        }
    }
    
    public var resourceUrl: String {
        switch self {
        case .bruteForceStringSearch:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Brute-Force%20String%20Search/README.markdown"
        case .knuthMorrisPratt:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Knuth-Morris-Pratt/README.markdown"
        case .rabinKarp:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Rabin-Karp/README.markdown"
        case .longestCommonSubsequence:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Longest%20Common%20Subsequence/README.markdown"
        case .zAlgorithm:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Z-Algorithm/README.markdown"
        }
    }
}
