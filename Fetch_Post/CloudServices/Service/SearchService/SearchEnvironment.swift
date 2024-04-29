//
//  SearchEnvironment.swift
//  CloudServices
//
//  Created by Ankit Kumar on 29/04/24.
//

import Foundation

/// Search environment helps to get the search endpoints
public struct SearchEnvironment: CloudEnvironment {
    /// Just to make initializer public
    public init() {}

    /// Returns baseURL
    /// - Returns: URL(optional)
    public func getBaseUrl(with query: String?) -> URL? {
        generateBaseEndpoint(with: query).url
    }

    private func generateBaseEndpoint(with query: String?) -> Endpoint {
        return Endpoint(
            scheme: getScheme(),
            host: getHost(),
            path: Constant.posts,
            queryItems: []
        )
    }
}
