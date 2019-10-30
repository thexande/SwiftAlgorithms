import Foundation

enum StringNetworkServiceError: Error {
    case contentLoadingFailure
}

final class StringNetworkService {
    public func fetchMarkdown(with url: URL,
                       completion: @escaping ((Result<String, StringNetworkServiceError>) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            do {
                let contents = try String(contentsOf: url)
                
                let urlFrag = "\("\(url)".components(separatedBy: "/").dropLast().joined(separator: "/"))/Images/"
                
                let fixedUrlMarkdown = contents.replacingOccurrences(of: "Images/", with: urlFrag)
                completion(.success(fixedUrlMarkdown))
            } catch {
                // contents could not be loaded
                completion(.failure(.contentLoadingFailure))
            }
        }
    }
}
