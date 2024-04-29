//
//  MockCloudRepo.swift
//  Find_PostTests
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
@testable import Find_Post
@testable import CloudServices

class MockCloudRepo: ICloudRepo {
    var completionResponse: Result<CloudServices.SearchResponse, CloudServices.ServiceError> = .failure(.invalidURL)
    func getRepositoryList(
        for query: String,
        completion: @escaping (Result<CloudServices.SearchResponse, CloudServices.ServiceError>) -> Void
    ) {
        completion(completionResponse)
    }
}
