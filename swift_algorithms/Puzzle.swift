enum Puzzle {
    static let allCases: [Puzzle] = [.twoSumProblem, .threeSumFourSumProblem, .fizzBuzz, .montyHallProblem, .findingPalindromes, .diningPhilosophers, .eggDrop, .encodingAndDecodingBinaryTree]
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
        
        case .twoSumProblem:
            return "Given an array of integers and an integer target, return the indices of two numbers that add up to the target."
        case .threeSumFourSumProblem:
            return "3Sum and 4Sum are extensions of a popular algorithm question, the 2Sum."
        case .fizzBuzz:
            return """
            Fizz buzz is a group word game for children to teach them about division. Players take turns to count incrementally, replacing any number divisible by three with the word "fizz", and any number divisible by five with the word "buzz".
            """
        case .montyHallProblem:
            return """
            Congrats! You've reached the final round of the popular Monty Hall game show. Monty, the show host, gives you the choice between 3 doors. Behind one of the doors is a prize (a new car? a trip to Hawaii? a microwave oven?), the other two are empty.
            """
        case .findingPalindromes:
            return "A palindrome is a word or phrase that is spelled the exact same when reading it forwards or backward. Palindromes are allowed to be lowercase or uppercase, contain spaces, punctuation, and word dividers."
        case .diningPhilosophers:
            return "The dining philosophers problem Algorithm implemented in Swift (concurrent algorithm design to illustrate synchronization issues and techniques for resolving them using GCD and Semaphore in Swift)"
        case .eggDrop:
            return "The egg drop problem is an interview question popularized by Google. The premise is simple; You're given a task to evaluate the shatter resistance of unknown objects by dropping them at a certain height. For simplicity, you test this by going inside a multi-story building and performing tests by dropping the objects out the window and onto the ground"
        case .encodingAndDecodingBinaryTree:
            return "Trees are complex structures. Unlike linear collections such as arrays or linked lists, trees are non-linear and each element in a tree has positional information such as the parent-child relationship between nodes. When you want to send a tree structure to your backend, you need to send the data of each node, and a way to represent the parent-child relationship for each node."
            
        default: return nil
        }
    }
    
    var resourceUrl: String {
        switch self {
        case .twoSumProblem:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Two-Sum%20Problem/README.markdown"
        case .threeSumFourSumProblem:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/3Sum%20and%204Sum/README.md"
        case .fizzBuzz:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Fizz%20Buzz/README.markdown"
        case .montyHallProblem:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Monty%20Hall%20Problem/README.markdown"
        case .findingPalindromes:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Palindromes/README.markdown"
        case .diningPhilosophers:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/DiningPhilosophers/README.md"
        case .eggDrop:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Egg%20Drop%20Problem/README.markdown"
        case .encodingAndDecodingBinaryTree:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Encode%20and%20Decode%20Tree/readme.md"
        }
    }
}
