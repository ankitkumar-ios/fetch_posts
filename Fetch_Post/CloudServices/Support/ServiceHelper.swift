//
//  ServiceHelper.swift
//  CloudServices
//
//  Created by Ankit Kumar on 29/04/24.
//

import Foundation

public protocol ServiceHelperProtocol {
    func executeRequest<T: Decodable>(request: URLRequest, completion: @escaping(Result<T, ServiceError>) -> Void)
}

public class ServiceHelper: ServiceHelperProtocol {
    let urlSession: URLSession

    public convenience init(timeout: TimeInterval = 10) {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = timeout
        sessionConfig.timeoutIntervalForResource = timeout
        sessionConfig.waitsForConnectivity = false
        self.init(config: sessionConfig)
    }

    init(config: URLSessionConfiguration) {
        self.urlSession = URLSession(configuration: config)
    }

    // MARK: - Execution
    public func executeRequest<T>(request: URLRequest, completion: @escaping (Result<T, ServiceError>) -> Void) where T : Decodable {
        let task = urlSession.dataTask(with: request) { data, response, error in
            self.parsingResponse(data: data, response: response, error: error, completion: completion)
        }
        task.resume()
    }
}

// MARK: - Parsing
extension ServiceHelper {
    /// Exposed for unit testing
    /// Generic function to Parse API response
    public func parsingResponse<T: Decodable>(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        completion: @escaping(Result<T, ServiceError>) -> Void
    ) {
        if let error = error as? NSError, error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorNetworkConnectionLost {
            print("No Internet connection")
            completion(.failure(.noInternet))
            return
        }
        
        #if DEBUG
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        print("StatusCode: \(String(describing: statusCode))")
        print("Response: \(String(describing: response))")
        print("Error: \(String(describing: error))")
        #endif

        switch statusCode {
        case HTTPStatusCode.ok.rawValue:
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.badData))
                }
            }

        default:
            if let errorCode = statusCode,
               let code = HTTPStatusCode(rawValue: errorCode) {
                completion(.failure(.responseError(code: code)))
            } else {
                completion(.failure(.responseError(code: .internalServerError)))
            }
        }
    }
}
