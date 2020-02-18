import Foundation
import SwiftAlgorithmsDataLayer

final class UrlFactory {
    private func url(for string: String) -> URL? {
        return URL(string: string)
    }
    
    func markdownFileUrl(for algorithmAction: Algorithm) -> URL? {
        return url(for: algorithmAction.resourceUrl)
    }
    
    func markdownFileUrl(for dataStructure: DataStructure) -> URL? {
        return url(for: dataStructure.resourceUrl)
    }
    
    func markdownFileUrl(for puzzle: Puzzle) -> URL? {
        return url(for: puzzle.resourceUrl)
    }
}
