import UIKit

enum DataStructure: CaseIterable {
    
    // Variations on Arrays
    case array2D
    case bitSet
    case fixedArraySize
    case orderedArray
    case rootishArrayStack
        
    // Queues
    case stack
    case queue
    case deque
    case priorityQueue
    case ringBuffer
    
    // Lists
    case linkedList
    case skipList
    
    // Trees
    case tree
    case binaryTree
    case binarySearchTree
    case redBlackTree
    case splayTree
    case threadedBinaryTree
    case segmentTree
    case sparseTable
    case heap
    case fibonacciHeap
    case Trie
    case bTree
    case quadTree
    case ocTree
    
    // Hashing
    case hashTable
    case hashFunctions
    
    // Sets
    case bloomFilter
    case hashSet
    case multiSet
    case orderedSet
    
    // Graph
    case graph
    case breadthFirstSearch
    case depthFirstSearch
    case shortestPath
    case singleSourceShortestPaths
    case minimumSpanningTreeUnweighted
    case minimumSpanningTree
    case allPairShortestPaths
    case dijkstrasShortestPath
    
    var category: DataStructure.Category? {
        return DataStructure.category(for: self)
    }
    
    var title: String {
        switch self {
        case .array2D:
            return "Array 2D"
        case .bitSet:
            return "Bit Set"
        case .fixedArraySize:
            return "Fixed Array Size"
        case .orderedArray:
            return "Ordered Array"
        case .rootishArrayStack:
            return "Rootish Array Stack"
        
        case .stack:
            return "Last-in, first-out!"
        case .queue:
            return "First-in, first-out"
        case .deque:
            return "A double-ended queue"
        case .priorityQueue:
            return "Priority Queue"
        case .ringBuffer:
            return "Ring Buffer"
        
        case .linkedList:
            return "Linked List"
        case .skipList:
            return "Skip List"
        
        case .tree:
            return "Tree"
        case .binaryTree:
            return "Binary Tree"
        case .binarySearchTree:
            return "Binary Search Tree"
        case .redBlackTree:
            return "Red-Black Tree"
        case .splayTree:
            return "Splay Tree"
        case .threadedBinaryTree:
            return "Threaded Binary Tree"
        case .segmentTree:
            return "Segmented Tree"
        case .sparseTable:
            return "Sparse Table"
        case .heap:
            return "Heap"
        case .fibonacciHeap:
            return "Fibonacci Heap"
        case .Trie:
            return "Trie"
        case .bTree:
            return "B-Treee"
        case .quadTree:
            return "QuadTree"
        case .ocTree:
            return "Octree"
        
        case .hashTable:
            return "Hash Table"
        case .hashFunctions:
            return "Hash Functions"
        
        case .bloomFilter:
            return "Bloom Filter"
        case .hashSet:
            return "Hash Set"
        case .multiSet:
            return "Multi Set"
        case .orderedSet:
            return "Ordered Set"
        
        case .graph:
            return "Graph"
        case .breadthFirstSearch:
            return "Breadth-First Search"
        case .depthFirstSearch:
            return "Depth-First Search"
        case .shortestPath:
            return "Shortest Path"
        case .singleSourceShortestPaths:
            return "Single-Source Shortest Paths"
        case .minimumSpanningTreeUnweighted:
            return "Minimum Spanning Tree (Unweighted)"
        case .minimumSpanningTree:
            return "Mimimum Spanning Tree"
        case .allPairShortestPaths:
            return "All-Pairs Shortest Paths"
        case .dijkstrasShortestPath:
            return "Dijkstra's Shortest Path Algortihm"
        }
    }
    
    var subtitle: String? {
        switch self {
            
        case .array2D:
            return "A two-dimensional array with fixed dimensions. Useful for board games."
        case .bitSet:
            return "A fixed-size sequence of n bits."
        case .fixedArraySize:
            return "When you know beforehand how large your data will be, it might be more efficient to use an old-fashioned array with a fixed size."
        case .orderedArray:
            return "An array that is always sorted."
        case .rootishArrayStack:
            return "A space and time efficient variation on Swift arrays."
        
        case .stack:
            return "Last-in, first-out!"
        case .queue:
            return "First-in, first-out!"
        case .deque:
            return "A double-ended queue."
        case .priorityQueue:
            return "A queue where the most important element is always at the front."
        case .ringBuffer:
            return "Also known as a circular buffer. An array of a certain size that conceptually wraps around back to the beginning."
        
        case .linkedList:
            return " A sequence of data items connected through links. Covers both singly and doubly linked lists."
        case .skipList:
            return "Skip List is a probabilistic data-structure with same logarithmic time bound and efficiency as AVL/ or Red-Black tree and provides a clever compromise to efficiently support search and update operations."
        
        case .tree:
            return " A general-purpose tree structure."
        case .binaryTree:
            return " A tree where each node has at most two children."
        case .binarySearchTree:
            return "A binary tree that orders its nodes in a way that allows for fast queries."
        case .redBlackTree:
            return "A self balancing binary search tree."
        case .splayTree:
            return "A self balancing binary search tree that enables fast retrieval of recently updated elements."
        case .threadedBinaryTree:
            return " binary tree that maintains a few extra variables for cheap and fast in-order traversals."
        case .segmentTree:
            return "Can quickly compute a function over a portion of an array."
        case .sparseTable:
            return "Another take on quickly computing a function over a portion of an array, but this time we'll make it even quicker!"
        case .heap:
            return "A binary tree stored in an array, so it doesn't use pointers. Makes a great priority queue."
        case .fibonacciHeap:
            return nil
        case .Trie:
            return "A special type of tree used to store associative data structures."
        case .bTree:
            return "A self-balancing search tree, in which nodes can have more than two children."
        case .quadTree:
            return "A tree with 4 children."
        case .ocTree:
            return "A tree with 8 children."
        
        case .hashTable:
            return "Allows you to store and retrieve objects by a key. This is how the dictionary type is usually implemented."
        case .hashFunctions:
            return nil

        case .bloomFilter:
            return "A constant-memory data structure that probabilistically tests whether an element is in a set."
        case .hashSet:
            return "A set implemented using a hash table."
        case .multiSet:
            return "A set where the number of times an element is added matters. (Also known as a bag.)"
        case .orderedSet:
            return " A set where the order of items matters."
        
        case .graph:
            return nil
        case .breadthFirstSearch:
            return nil
        case .depthFirstSearch:
            return nil
        case .shortestPath:
            return "on an unweighted tree"
        case .singleSourceShortestPaths:
            return nil
        case .minimumSpanningTreeUnweighted:
            return "on an unweighted tree"
        case .minimumSpanningTree:
            return nil
        case .allPairShortestPaths:
            return nil
        case .dijkstrasShortestPath:
            return nil
        }
    }
    
    static func category(for dataStructure: DataStructure) -> DataStructure.Category {
        switch dataStructure {
        // Variations on Arrays
        case .array2D, .bitSet, .fixedArraySize, .orderedArray, .rootishArrayStack:
            return .array
            
        // Queues
        case .stack, .queue, .deque, .priorityQueue, .ringBuffer:
            return .queue
            
        // Lists
        case .linkedList, .skipList:
            return .list
            
        // Trees
        case .tree, .binaryTree, .binarySearchTree, .redBlackTree, .splayTree, .threadedBinaryTree, .segmentTree, .sparseTable, .heap, .fibonacciHeap, .Trie, .bTree, .quadTree, .ocTree:
            return .tree
            
        // Hashing
        case .hashTable, .hashFunctions:
            return .hash
            
        // Sets
        case .bloomFilter, .hashSet, .multiSet, .orderedSet:
            return .set
            
        // Graph
        case .graph, .breadthFirstSearch, .depthFirstSearch, .shortestPath, .singleSourceShortestPaths, .minimumSpanningTreeUnweighted, .minimumSpanningTree, .allPairShortestPaths, .dijkstrasShortestPath:
            return .graph
        }
    }
    
    enum Category: CaseIterable {
        case array
        case queue
        case list
        case tree
        case hash
        case set
        case graph
        
        var title: String {
            switch self {
            case .array:
                return "Arrays"
            case .queue:
                return "Queues"
            case .list:
                return "Lists"
            case .tree:
                return "Trees"
            case .hash:
                return "Hashes"
            case .set:
                return "Sets"
            case .graph:
                return "Graphs"
            }
        }
        
        var color: UIColor {
            switch self {
            case .array:
                return .newYellow()
            case .queue:
                return .newBlue()
            case .list:
                return .coral()
            case .tree:
                return .amethist()
            case .hash:
                return .newGreen()
            case .set:
                return .newLightBlue()
            case .graph:
                return .newPink()
            }
        }
        
        var image: UIImage {
            return UIImage()
        }
        
        var dataStructures: [DataStructure] {
            switch self {
            case .array:
                return [.array2D, .bitSet, .fixedArraySize, .orderedArray, .rootishArrayStack]
            case .queue:
                return [.stack, .queue, .deque, .priorityQueue, .ringBuffer]
            case .list:
                return [.linkedList, .skipList]
            case .tree:
                return [.tree, .binaryTree, .binarySearchTree, .redBlackTree, .splayTree, .threadedBinaryTree, .segmentTree, .sparseTable, .heap, .fibonacciHeap, .Trie, .bTree, .quadTree, .ocTree]
            case .hash:
                return [.hashTable, .hashFunctions]
            case .set:
                return [.bloomFilter, .hashSet, .multiSet, .orderedSet]
            case .graph:
                return [.graph, .breadthFirstSearch, .depthFirstSearch, .shortestPath, .singleSourceShortestPaths, .minimumSpanningTreeUnweighted, .minimumSpanningTree, .allPairShortestPaths, .dijkstrasShortestPath]
            }
        }
    }
}
