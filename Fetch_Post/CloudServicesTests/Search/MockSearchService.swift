//
//  MockSearchService.swift
//  CloudServicesTests
//
//  Created by Ankit Kumar on 29/04/24.
//

import Foundation
@testable import CloudServices

class MockSearchService: SearchServiceProtocol {
    var response: Result<SearchResponse, ServiceError>

    init(response: Result<SearchResponse, ServiceError>) {
        self.response = response
    }

    func getPostList(
        for language: String,
        completion: @escaping (Result<CloudServices.SearchResponse, CloudServices.ServiceError>) -> Void
    ) {
        completion(response)
    }
}
