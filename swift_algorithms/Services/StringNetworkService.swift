import Foundation

enum StringNetworkServiceError: Error {
    case contentLoadingFailure
}

final class StringNetworkService {
    public func fetchMarkdown(with url: URL,
                       completion: @escaping ResultHandler<String>) {
        DispatchQueue.global(qos: .background).async {
            do {
                let contents = try String(contentsOf: url)
                completion(.success(contents))
            } catch {
                // contents could not be loaded
                completion(.failure(StringNetworkServiceError.contentLoadingFailure))
            }
        }
    }
}
