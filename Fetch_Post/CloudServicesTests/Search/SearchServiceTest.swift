//
//  SearchServiceTest.swift
//  CloudServicesTests
//
//  Created by Ankit Kumar on 29/04/24.
//

import XCTest
@testable import CloudServices

final class SearchServiceTest: XCTestCase {

    func testSearchResponse() throws {
        let expectedResponse = MockResponseJSON().getSearchSuccessResponse()
        let service = MockSearchService(response: .success(expectedResponse))

        let expectation = XCTestExpectation(description: "Wait for response callback")

        service.getRepositoryList(for: "Swift") { response in
            switch response {
            case .failure(_):
                XCTFail("Should not get any error")

            case let .success(actualResponse):
                if expectedResponse.totalCount == actualResponse.totalCount &&
                    expectedResponse.items?.count == actualResponse.items?.count {
                    expectation.fulfill()
                }
            }
        }

        wait(for: [expectation], timeout: 2)
    }
}
