enum MathematicsAlgorithm: CaseIterable {
    case gcd
    case permutationsAndCombinations
    case shuntingYard
    case karatsubaMultiplication
    case haversineDistance
    case strassenMultiplicationMatrix
}

extension MathematicsAlgorithm: Algorithm {
    
    var category: AlgorithmCategory {
        return .math
    }
    
    var subtitle: String? {
        switch self {
        case .gcd:
            return "Special bonus: the least common multiple."
        case .permutationsAndCombinations:
            return "Get your combinatorics on!"
        case .shuntingYard:
            return "Convert infix expressions to postfix."
        case .karatsubaMultiplication:
            return "Another take on elementary multiplication."
        case .haversineDistance:
            return "Calculating the distance between 2 points from a sphere."
        case .strassenMultiplicationMatrix:
            return "Efficient way to handle matrix multiplication."
        }
    }
    
    var title: String {
        switch self {
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
        }
    }
    
    var resourceUrl: String {
        switch self {
        case .gcd:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/GCD/README.markdown"
        case .permutationsAndCombinations:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Combinatorics/README.markdown"
        case .shuntingYard:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Shunting%20Yard/README.markdown"
        case .karatsubaMultiplication:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Karatsuba%20Multiplication/README.markdown"
        case .haversineDistance:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/HaversineDistance/README.md"
        case .strassenMultiplicationMatrix:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Strassen%20Matrix%20Multiplication/README.markdown"
        }
    }
}
