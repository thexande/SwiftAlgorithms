import UIKit

final class AlgorithmPresenter {
    weak var dispatcher: RowActionDispatching?
    
    public func makeIntroSectionSection() -> ActionTableSectionController {
        
        let actionSection = ActionTableSectionController()
        
        let rowProps: [ActionTableRowController.Properties] = [
            ActionTableRowController.Properties(title: "What are algorithms and data structures?", subtitle: "Pancakes!", icon: UIImage(named: "pancakes"), action: .whatAreAlgorithms),
            ActionTableRowController.Properties(title: "Why learn algorithms?", subtitle: "Worried this isn't your cup of tea? Then read this.", icon: UIImage(named: "?"), action: .whyLearnAlgorithms),
            ActionTableRowController.Properties(title: "Big-O notation", subtitle: "We often say things like, 'This algorithm is O(n).' If you don't know what that means, read this first.", icon: UIImage(named: "line_chart"), action: .bigO),
            ActionTableRowController.Properties(title: "Algorithm design techniques", subtitle: "How do you create your own algorithms?", icon: UIImage(named: "algo")?.withRenderingMode(.alwaysTemplate), action: .designTechniques),
            ActionTableRowController.Properties(title: "How to contribute", subtitle: "Report an issue to leave feedback, or submit a pull request.", icon: UIImage(named: "git"), action: .howToContribute)
            
        ]
        
        let actionRows = rowProps.map(ActionTableRowController.map)
        
        actionSection.rows = actionRows
        actionSection.dispatcher = self.dispatcher
        return actionSection
    }
    
    public func makeGettingStartedSection() -> BasicTableSectionController {
        let starterSection = BasicTableSectionController()
        
        let starterRowProps = [
            BasicTableRowController.Properties(title: "Stack", subtitle: nil, showsDisclosure: true, action: .stack),
            BasicTableRowController.Properties(title: "Queue", subtitle: nil, showsDisclosure: true, action: .queue),
            BasicTableRowController.Properties(title: "Insertion Sort", subtitle: nil, showsDisclosure: true, action: .insertionSort),
            BasicTableRowController.Properties(title: "Binary Search", subtitle: nil, showsDisclosure: true, action: .binarySearch),
            BasicTableRowController.Properties(title: "Binary Search Tree", subtitle: nil, showsDisclosure: true, action: .binarySearchTree),
            BasicTableRowController.Properties(title: "Merge Sort", subtitle: nil, showsDisclosure: true, action: .mergeSort),
            BasicTableRowController.Properties(title: "Boyer-Moore string search", subtitle: nil, showsDisclosure: true, action: .boyerMoore),
            
            ]
        
        starterSection.rows = starterRowProps.map(BasicTableRowController.map)
        starterSection.dispatcher = self.dispatcher
        
        starterSection.sectionTitle = "Where to start?"
        starterSection.sectionSubtitle = "If you're new to algorithms and data structures, here are a few good ones to start out with:"
        
        return starterSection
    }
    
    public func makeSearchingSection() -> BasicTableSectionController {
        
        let searchingRowProps = [
            BasicTableRowController.Properties(title: "Linnear Search", subtitle: "Find an element in an array.", showsDisclosure: true, action: .linnearSearch),
            BasicTableRowController.Properties(title: "Binary Search", subtitle: "Quickly find elements in a sorted array.", showsDisclosure: true, action: .binarySearch),
            BasicTableRowController.Properties(title: "Count Occurrences", subtitle: "Count how often a value appears in an array.", showsDisclosure: true, action: .countOccurences),
            BasicTableRowController.Properties(title: "Select Minimum / Maximum", subtitle: "Find the minimum/maximum value in an array.", showsDisclosure: true, action: .selectMinMax),
            BasicTableRowController.Properties(title: "k-th Largest Element.", subtitle: "Find the k-th largest element in an array, such as the median.", showsDisclosure: true, action: .kthLargestElement),
            BasicTableRowController.Properties(title: "Selection Sampling", subtitle: "Randomly choose a bunch of items from a collection.", showsDisclosure: true, action: .selectionSampling),
            BasicTableRowController.Properties(title: "Union-Find", subtitle: "Keeps track of disjoint sets and lets you quickly merge them.", showsDisclosure: true, action: .unionFind),
            ]
        
        let searchingRowSection = BasicTableSectionController()
        let searchingRows = searchingRowProps.map(BasicTableRowController.map)
        searchingRowSection.rows = searchingRows
        searchingRowSection.sectionTitle = "Searching"
        searchingRowSection.dispatcher = self.dispatcher
        
        return searchingRowSection
    }
    
    public func makeStringSearchSection() -> BasicTableSectionController {
        
        let searchRowProps = [
            BasicTableRowController.Properties(title: "Brute-Force String Search", subtitle: "A naive method", showsDisclosure: true, action: .bruteForceStringSearch),
            BasicTableRowController.Properties(title: "Boyer-Moore", subtitle: "A fast method to search for substrings. It skips ahead based on a look-up table, to avoid looking at every character in the text.", showsDisclosure: true, action: .boyerMoore),
            BasicTableRowController.Properties(title: "Knuth-Morris-Pratt", subtitle: "A linear-time string algorithm that returns indexes of all occurrencies of a given pattern.", showsDisclosure: true, action: .knuthMorrisPratt),
            BasicTableRowController.Properties(title: "Rabin-Karp", subtitle: "Faster search by using hashing.", showsDisclosure: true, action: .rabinKarp),
            BasicTableRowController.Properties(title: "Longest Common Subsequence", subtitle: "Find the longest sequence of characters that appear in the same order in both strings.", showsDisclosure: true, action: .longestCommonSubsequence),
            BasicTableRowController.Properties(title: "Z-Algorithm", subtitle: " Finds all instances of a pattern in a String, and returns the indexes of where the pattern starts within the String.", showsDisclosure: true, action: .zAlgorithm)
        ]
        
        let searchingRowSection = BasicTableSectionController()
        let searchingRows = searchRowProps.map(BasicTableRowController.map)
        
        searchingRowSection.rows = searchingRows
        searchingRowSection.sectionTitle = "String Search"
        searchingRowSection.dispatcher = self.dispatcher
        return searchingRowSection
    }
    
}

extension AlgorithmPresenter: RowActionDispatching {
    func dispatch(_ action: AlgorithmViewController.Action) {
        switch action {
        default: dispatcher?.dispatch(action)
        }
    }
}
