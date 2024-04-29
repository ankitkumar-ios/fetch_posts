//
//  CommentService.swift
//  CloudServices
//
//  Created by Ankit Kumar on 29/04/24.
//

import Foundation

protocol CommentServiceProtocol {
    func getCommentList(
        for language: String,
        completion: @escaping(Result<CommentResponse, ServiceError>) -> Void
    )
}

public struct CommentService: CommentServiceProtocol {
    private let environment: CloudEnvironment
    private let serviceHelper: ServiceHelperProtocol
    public static let timeout: TimeInterval = 10

    /// Setting the init with environment to get the baseUrl
    /// - Parameters:
    ///   - environment: CloudEnvironemnt
    ///   - serviceHelper: ServiceHelper
    public init(
        environment: CloudEnvironment = CommentEnvironment(),
        serviceHelper: ServiceHelper = ServiceHelper(timeout: CommentService.timeout)
    ) {
        self.environment = environment
        self.serviceHelper = serviceHelper
    }

    /// Get list of repository data from the API call
    /// - Parameter completion: Getting success or failure
    public func getCommentList(
        for query: String,
        completion: @escaping(Result<CommentResponse, ServiceError>) -> Void
    ) {
        guard let url = environment.getBaseUrl(with: query) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue(HTTPConstant.headerValueContentTypeJson, forHTTPHeaderField: HTTPConstant.headerKeyContentType)
        serviceHelper.executeRequest(request: request, completion: completion)
    }
}
