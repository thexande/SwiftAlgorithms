import Foundation
import Cache

public enum StringNetworkServiceError: Error {
    case contentLoadingFailure
}

public protocol StringNetworkServiceInterface {
    func fetchMarkdown(with url: URL,
                       completion: @escaping ((Swift.Result<String, StringNetworkServiceError>) -> Void))
}

public final class StringNetworkService: StringNetworkServiceInterface {
    
    public init() { }
    
    public func fetchMarkdown(with url: URL,
                              completion: @escaping ((Swift.Result<String, StringNetworkServiceError>) -> Void)) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let myself = self else { return }
            
            do {
           let diskConfig = DiskConfig(name: "markdown")
                let memoryConfig = MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10)

                let storage = try Storage(diskConfig: diskConfig,
                                           memoryConfig: memoryConfig,
                                           transformer: TransformerFactory.forCodable(ofType: String.self))
                completion(.success(try storage.object(forKey: url.absoluteString)))
            } catch {
                print("Did not find entry in cache for \(url.absoluteString) with error: \(error)")
                myself.fetchAndCache(contentsOf: url, completion: completion)
            }
        }
    }
    
    private func fetchAndCache(contentsOf url: URL,
                               completion: @escaping ((Swift.Result<String, StringNetworkServiceError>) -> Void)) {
        do {
            let contents = try String(contentsOf: url)
            let urlFrag = "\("\(url)".components(separatedBy: "/").dropLast().joined(separator: "/"))/Images/"
            let fixedUrlMarkdown = contents.replacingOccurrences(of: "Images/", with: urlFrag)
            
            let diskConfig = DiskConfig(name: "markdown")
            let memoryConfig = MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10)
            
            let storage = try Storage(diskConfig: diskConfig,
                                      memoryConfig: memoryConfig,
                                      transformer: TransformerFactory.forCodable(ofType: String.self))
            try storage.setObject(fixedUrlMarkdown, forKey: url.absoluteString)
            completion(.success(fixedUrlMarkdown))
        } catch {
            // contents could not be loaded
            completion(.failure(.contentLoadingFailure))
        }
    }
}
