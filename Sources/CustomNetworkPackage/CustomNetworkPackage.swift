// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public class CustomNetworkPackage {
    
    public static let shared = CustomNetworkPackage()
    private init() {}
    
    public func performRequest(to urlString: String,
                               method: HTTPMethod,
                               body: Data? = nil,
                               bearerToken: String? = nil,
                               completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(nil, nil, NSError(domain: "NetworkManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = bearerToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        request.httpBody = body
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
    
    // Helper methods for specific HTTP methods
    public func getRequest(url: String, bearerToken: String?, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        performRequest(to: url, method: .get, bearerToken: bearerToken, completion: completion)
    }
    
    public func postRequest(url: String, body: Data?, bearerToken: String?, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        performRequest(to: url, method: .post, body: body, bearerToken: bearerToken, completion: completion)
    }
    
    public func putRequest(url: String, body: Data?, bearerToken: String?, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        performRequest(to: url, method: .put, body: body, bearerToken: bearerToken, completion: completion)
    }
    
    public func deleteRequest(url: String, bearerToken: String?, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        performRequest(to: url, method: .delete, bearerToken: bearerToken, completion: completion)
    }
    
    // MARK: - HTTPMethod Enum
    public enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}
