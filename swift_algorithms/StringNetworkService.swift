import Foundation
import Result

enum StringNetworkServiceError: Error {
    case contentLoadingFailure
}

final class StringNetworkService {
    public func fetchMarkdown(with url: URL,
                       completion: @escaping ((Result<String, StringNetworkServiceError>) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            do {
                let contents = try String(contentsOf: url)
                completion(.success(contents))
            } catch {
                // contents could not be loaded
                completion(.failure(.contentLoadingFailure))
            }
        }
    }
}
