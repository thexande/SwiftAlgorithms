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
    
    
    public func makeSortingSection() -> BasicTableSectionController {
        var sortingRows: [RowController] = []
        
        // configure basic sorts
        
        let basicSorts = [
            BasicTableRowController.Properties(title: "Insertion Sort", subtitle: nil, showsDisclosure: true, action: .insertionSort),
            BasicTableRowController.Properties(title: "Selection Sort", subtitle: nil, showsDisclosure: true, action: .selectionSort),
            BasicTableRowController.Properties(title: "Shell Sort", subtitle: nil, showsDisclosure: true, action: .shellSort),
        ]
        
        let basicSortHeader = BasicTableHeaderRowController.map(BasicTableHeaderRowController.Properties(title: "Basic Sorts"))
        sortingRows.append(basicSortHeader)
        sortingRows.append(contentsOf: basicSorts.map(BasicTableRowController.map))
        
        // configure fast sorts
        
        let fastSorts = [
            BasicTableRowController.Properties(title: "QuickSort", subtitle: nil, showsDisclosure: true, action: .quickSort),
            BasicTableRowController.Properties(title: "Merge Sort", subtitle: nil, showsDisclosure: true, action: .mergeSort),
            BasicTableRowController.Properties(title: "Heap Sort", subtitle: nil, showsDisclosure: true, action: .heapSort),
        ]
        
        let fastSortHeader = BasicTableHeaderRowController.map(BasicTableHeaderRowController.Properties(title: "Fast Sorts"))
        sortingRows.append(fastSortHeader)
        sortingRows.append(contentsOf: fastSorts.map(BasicTableRowController.map))
        
        // configure hybrid sorts
        
        let hybridSorts = [
            BasicTableRowController.Properties(title: "Introsort", subtitle: nil, showsDisclosure: true, action: .introSort),
        ]
        
        let hybridSortHeader = BasicTableHeaderRowController.map(BasicTableHeaderRowController.Properties(title: "Fast Sorts"))
        sortingRows.append(hybridSortHeader)
        sortingRows.append(contentsOf: hybridSorts.map(BasicTableRowController.map))
        
        // configure special purpose sorts
        
        let specialPurposeSorts = [
            BasicTableRowController.Properties(title: "Counting Sort", subtitle: nil, showsDisclosure: true, action: .countingSort),
            BasicTableRowController.Properties(title: "Radix Sort", subtitle: nil, showsDisclosure: true, action: .radixSort),
            BasicTableRowController.Properties(title: "Topological Sort", subtitle: nil, showsDisclosure: true, action: .topologicalSort),
        ]
        
        let specialPurposeSortHeader = BasicTableHeaderRowController.map(BasicTableHeaderRowController.Properties(title: "Basic Sorts"))
        sortingRows.append(specialPurposeSortHeader)
        sortingRows.append(contentsOf: specialPurposeSorts.map(BasicTableRowController.map))
        
        // configure bad sorts
        
        let badSorts = [
            BasicTableRowController.Properties(title: "Bubble Sort", subtitle: nil, showsDisclosure: true, action: .bubbleSort),
            BasicTableRowController.Properties(title: "Slow Sort", subtitle: nil, showsDisclosure: true, action: .slowSort),
        ]
        
        let badSortHeader = BasicTableHeaderRowController.map(BasicTableHeaderRowController.Properties(title: "Basic Sorts"))
        sortingRows.append(badSortHeader)
        sortingRows.append(contentsOf: badSorts.map(BasicTableRowController.map))
        
        
        let sortingRowsSection = BasicTableSectionController()
        
        sortingRowsSection.rows = sortingRows
        sortingRowsSection.sectionTitle = "Sorting"
        sortingRowsSection.sectionSubtitle = "It's fun to see how sorting algorithms work, but in practice you'll almost never have to provide your own sorting routines. Swift's own sort() is more than up to the job. But if you're curious, read on..."
        sortingRowsSection.dispatcher = self.dispatcher
        
        return sortingRowsSection
    }
    
    public func makeCompressionSection() -> BasicTableSectionController {
        let compressionRowProps = [
            BasicTableRowController.Properties(title: "Run-Length Encoding (RLE).", subtitle: "Store repeated values as a single byte and a count.", showsDisclosure: true, action: .runLengthEncoding),
            BasicTableRowController.Properties(title: "Huffman Coding", subtitle: "Store more common elements using a smaller number of bits.", showsDisclosure: true, action: .huffmanCoding),
        ]
        
        let compressionRowSection = BasicTableSectionController()
        let compressionRows = compressionRowProps.map(BasicTableRowController.map)
        
        compressionRowSection.rows = compressionRows
        compressionRowSection.sectionTitle = "Compression"
        compressionRowSection.dispatcher = self.dispatcher
        return compressionRowSection
    }
}

extension AlgorithmPresenter: RowActionDispatching {
    func dispatch(_ action: AlgorithmViewController.Action) {
        switch action {
        default: dispatcher?.dispatch(action)
        }
    }
}
