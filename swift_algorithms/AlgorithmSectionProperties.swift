struct AlgorithmSectionProperties {
    public static func allAlgorithmProperties() -> [BasicTableRowController.Properties] {
        let all: [[BasicTableRowController.Properties]] = [
            Sorting.bad,
            Sorting.basic,
            Sorting.fast,
            Sorting.hybrid,
            Sorting.special,
            gettingStartedSectionProperties,
            searchingSectionProperties,
            stringSearchingSectionProperties,
            compressionSectionProperties,
            miscellaneousSectionProperties,
            machineLearningSectionProperties,
            mathSectionProperties
        ]
        return all.flatMap { $0 }
    }
    
    public struct Sorting {
        public static let basic: [BasicTableRowController.Properties] = [
            BasicTableRowController.Properties(title: "Insertion Sort", subtitle: nil, showsDisclosure: true, action: .insertionSort),
            BasicTableRowController.Properties(title: "Selection Sort", subtitle: nil, showsDisclosure: true, action: .selectionSort),
            BasicTableRowController.Properties(title: "Shell Sort", subtitle: nil, showsDisclosure: true, action: .shellSort),
            ]
        
        public static let fast: [BasicTableRowController.Properties] = [
            BasicTableRowController.Properties(title: "QuickSort", subtitle: nil, showsDisclosure: true, action: .quickSort),
            BasicTableRowController.Properties(title: "Merge Sort", subtitle: nil, showsDisclosure: true, action: .mergeSort),
            BasicTableRowController.Properties(title: "Heap Sort", subtitle: nil, showsDisclosure: true, action: .heapSort),
            ]
        
        public static let hybrid: [BasicTableRowController.Properties] = [
            BasicTableRowController.Properties(title: "Introsort", subtitle: nil, showsDisclosure: true, action: .introSort),
            ]
        
        public static let special: [BasicTableRowController.Properties] = [
            BasicTableRowController.Properties(title: "Counting Sort", subtitle: nil, showsDisclosure: true, action: .countingSort),
            BasicTableRowController.Properties(title: "Radix Sort", subtitle: nil, showsDisclosure: true, action: .radixSort),
            BasicTableRowController.Properties(title: "Topological Sort", subtitle: nil, showsDisclosure: true, action: .topologicalSort),
            ]
        
        public static let bad: [BasicTableRowController.Properties] = [
        BasicTableRowController.Properties(title: "Bubble Sort", subtitle: nil, showsDisclosure: true, action: .bubbleSort),
        BasicTableRowController.Properties(title: "Slow Sort", subtitle: nil, showsDisclosure: true, action: .slowSort),
        ]
    }
    
    public static let gettingStartedSectionProperties: [BasicTableRowController.Properties] = [
        BasicTableRowController.Properties(title: "Stack", subtitle: nil, showsDisclosure: true, action: .stack),
        BasicTableRowController.Properties(title: "Queue", subtitle: nil, showsDisclosure: true, action: .queue),
        BasicTableRowController.Properties(title: "Insertion Sort", subtitle: nil, showsDisclosure: true, action: .insertionSort),
        BasicTableRowController.Properties(title: "Binary Search", subtitle: nil, showsDisclosure: true, action: .binarySearch),
        BasicTableRowController.Properties(title: "Binary Search Tree", subtitle: nil, showsDisclosure: true, action: .binarySearchTree),
        BasicTableRowController.Properties(title: "Merge Sort", subtitle: nil, showsDisclosure: true, action: .mergeSort),
        BasicTableRowController.Properties(title: "Boyer-Moore string search", subtitle: nil, showsDisclosure: true, action: .boyerMoore),]
    
    public static let searchingSectionProperties: [BasicTableRowController.Properties] = [
        BasicTableRowController.Properties(title: "Linnear Search", subtitle: "Find an element in an array.", showsDisclosure: true, action: .linnearSearch),
        BasicTableRowController.Properties(title: "Binary Search", subtitle: "Quickly find elements in a sorted array.", showsDisclosure: true, action: .binarySearch),
        BasicTableRowController.Properties(title: "Count Occurrences", subtitle: "Count how often a value appears in an array.", showsDisclosure: true, action: .countOccurences),
        BasicTableRowController.Properties(title: "Select Minimum / Maximum", subtitle: "Find the minimum/maximum value in an array.", showsDisclosure: true, action: .selectMinMax),
        BasicTableRowController.Properties(title: "k-th Largest Element.", subtitle: "Find the k-th largest element in an array, such as the median.", showsDisclosure: true, action: .kthLargestElement),
        BasicTableRowController.Properties(title: "Selection Sampling", subtitle: "Randomly choose a bunch of items from a collection.", showsDisclosure: true, action: .selectionSampling),
        BasicTableRowController.Properties(title: "Union-Find", subtitle: "Keeps track of disjoint sets and lets you quickly merge them.", showsDisclosure: true, action: .unionFind),
        ]
    
    public static let stringSearchingSectionProperties: [BasicTableRowController.Properties] =  [
        BasicTableRowController.Properties(title: "Brute-Force String Search", subtitle: "A naive method", showsDisclosure: true, action: .bruteForceStringSearch),
        BasicTableRowController.Properties(title: "Boyer-Moore", subtitle: "A fast method to search for substrings. It skips ahead based on a look-up table, to avoid looking at every character in the text.", showsDisclosure: true, action: .boyerMoore),
        BasicTableRowController.Properties(title: "Knuth-Morris-Pratt", subtitle: "A linear-time string algorithm that returns indexes of all occurrencies of a given pattern.", showsDisclosure: true, action: .knuthMorrisPratt),
        BasicTableRowController.Properties(title: "Rabin-Karp", subtitle: "Faster search by using hashing.", showsDisclosure: true, action: .rabinKarp),
        BasicTableRowController.Properties(title: "Longest Common Subsequence", subtitle: "Find the longest sequence of characters that appear in the same order in both strings.", showsDisclosure: true, action: .longestCommonSubsequence),
        BasicTableRowController.Properties(title: "Z-Algorithm", subtitle: " Finds all instances of a pattern in a String, and returns the indexes of where the pattern starts within the String.", showsDisclosure: true, action: .zAlgorithm)
    ]
    
    public static let compressionSectionProperties: [BasicTableRowController.Properties] = [
        BasicTableRowController.Properties(title: "Run-Length Encoding (RLE)", subtitle: "Store repeated values as a single byte and a count.", showsDisclosure: true, action: .runLengthEncoding),
        BasicTableRowController.Properties(title: "Huffman Coding", subtitle: "Store more common elements using a smaller number of bits.", showsDisclosure: true, action: .huffmanCoding),
        ]
    
    public static let miscellaneousSectionProperties: [BasicTableRowController.Properties] = [
        BasicTableRowController.Properties(title: "Shuffle", subtitle: "Randomly rearranges the contents of an array.", showsDisclosure: true, action: .shuffle),
        BasicTableRowController.Properties(title: "Combo Sort", subtitle: "An improve upon the Bubble Sort algorithm.", showsDisclosure: true, action: .comboSort),
        BasicTableRowController.Properties(title: "Convex Hull", subtitle: " The Convex Hull algorithm calculates the shape (made up from the points itself) containing all these points.", showsDisclosure: true, action: .convexHull),
        
        BasicTableRowController.Properties(title: "Shuffle", subtitle: "Randomly rearranges the contents of an array.", showsDisclosure: true, action: .shuffle),
        BasicTableRowController.Properties(title: "Miller-Rabin Primality Test", subtitle: "Is the number a prime number?", showsDisclosure: true, action: .millerRabin),
        BasicTableRowController.Properties(title: "MinimumCoinChange", subtitle: "A showcase for dynamic programming.", showsDisclosure: true, action: .minimumCoin),
        ]
    
    public static let machineLearningSectionProperties: [BasicTableRowController.Properties] = [
        BasicTableRowController.Properties(title: "k-Means Clustering", subtitle: "Unsupervised classifier that partitions data into k clusters", showsDisclosure: true, action: .kMeansClustering),
        BasicTableRowController.Properties(title: "Linear Regression", subtitle: "A technique for creating a model of the relationship between two (or more) variable quantities.", showsDisclosure: true, action: .linnearRegression),
        BasicTableRowController.Properties(title: "Naive Bayes Classifier", subtitle: "The goal of a classifier is to predict the class of a given data entry based on previously fed data and its features.", showsDisclosure: true, action: .naiveBayesClassifier),
        BasicTableRowController.Properties(title: "Simulated Annealing", subtitle: "Probabilistic technique for approximating the global maxima in a (often discrete) large search space.", showsDisclosure: true, action: .simulatedAnnealing),
        ]
    
    public static let mathSectionProperties: [BasicTableRowController.Properties] = [
        BasicTableRowController.Properties(title: "Greatest Common Divisor (GCD)", subtitle: "Special bonus: the least common multiple.", showsDisclosure: true, action: .gcd),
        BasicTableRowController.Properties(title: "Permutations and Combinations", subtitle: "Get your combinatorics on!", showsDisclosure: true, action: .permutationsAndCombinations),
        BasicTableRowController.Properties(title: "Shunting Yard Algorithm", subtitle: "Convert infix expressions to postfix.", showsDisclosure: true, action: .permutationsAndCombinations),
        BasicTableRowController.Properties(title: "Karatsuba Multiplication", subtitle: "Another take on elementary multiplication.", showsDisclosure: true, action: .karatsubaMultiplication),
        BasicTableRowController.Properties(title: "Haversine Distance", subtitle: "Calculating the distance between 2 points from a sphere.", showsDisclosure: true, action: .haversineDistance),
        BasicTableRowController.Properties(title: "Strassen's Multiplication Matrix", subtitle: "Efficient way to handle matrix multiplication.", showsDisclosure: true, action: .strassenMultiplicationMatrix),
        ]
 }
