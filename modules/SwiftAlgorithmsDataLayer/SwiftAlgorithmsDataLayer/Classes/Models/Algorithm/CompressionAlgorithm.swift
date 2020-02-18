public enum CompressionAlgorithm: CaseIterable {
    case runLengthEncoding
    case huffmanCoding
}

extension CompressionAlgorithm: Algorithm {

    public var category: AlgorithmCategory {
        return .compression
    }
    
    public var title: String {
        switch self {
        case .runLengthEncoding:
            return "Run Length Encoding"
        case .huffmanCoding:
            return "Huffman Coding"
        }
    }
    
    public var subtitle: String? {
        switch self {
        case .runLengthEncoding:
            return "Store repeated values as a single byte and a count."
        case .huffmanCoding:
            return "Store more common elements using a smaller number of bits."
        }
    }
    
    public var resourceUrl: String {
        switch self {
        case .runLengthEncoding:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Run-Length%20Encoding/README.markdown"
        case .huffmanCoding:
            return "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Huffman%20Coding/README.markdown"
        }
    }
}
