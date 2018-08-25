enum Puzzle: CaseIterable {
    case twoSumProblem
    case threeSumFourSumProblem
    case fizzBuzz
    case montyHallProblem
    case findingPalindromes
    case diningPhilosophers
    case eggDrop
    case encodingAndDecodingBinaryTree
    
    var title: String {
        switch self {
        case .twoSumProblem:
            return "Two-Sum Problem"
        case .threeSumFourSumProblem:
            return "Three-Sum/Four-Sum Problem"
        case .fizzBuzz:
            return "Fizz Buzz"
        case .montyHallProblem:
            return "Monty Hall Problem"
        case .findingPalindromes:
            return "Finding Palindromes"
        case .diningPhilosophers:
            return "Dining Philosophers"
        case .eggDrop:
            return "Egg Drop Problem"
        case .encodingAndDecodingBinaryTree:
            return "Encoding and Decoding Binart Tree"
        }
    }
    
    static let detailInfo: String = "A lot of software developer interview questions consist of algorithmic puzzles. Here is a small selection of fun ones."
    
    var subtitle: String? {
        switch self {
        default: return nil
        }
    }
    
    var resourceUrl: String {
        switch self {
        case .twoSumProblem:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Two-Sum%20Problem/README.markdown"
        default: return ""
//        case .threeSumFourSumProblem:
//            <#code#>
//        case .fizzBuzz:
//            <#code#>
//        case .montyHallProblem:
//            <#code#>
//        case .findingPalindromes:
//            <#code#>
//        case .diningPhilosophers:
//            <#code#>
//        case .eggDrop:
//            <#code#>
//        case .encodingAndDecodingBinaryTree:
//            <#code#>
        }
    }
}
