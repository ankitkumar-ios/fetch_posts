//
//  DashboardInteractorTest.swift
//  Find_PostTests
//
//  Created by Ankit Kumar on 29/04/24.
//

import XCTest
@testable import CloudServices
@testable import Find_Post

final class DashboardInteractorTest: XCTestCase {
    func test_repositoryDataFetchedSuccess_called() throws {
        let interactor = DashboardIntractor()
        let presenter = MockDashboardPresenter()
        let cloudRepo = MockCloudRepo()

        interactor.presenter = presenter
        presenter.interactor = interactor
        interactor.cloudRepo = cloudRepo

        cloudRepo.completionResponse = .success(SearchResponse())
        interactor.fetchRepositoryData(for: "Swift")
        XCTAssertEqual(1, presenter.dataFetchedSuccessCounter)

        cloudRepo.completionResponse = .failure(.responseError(code: HTTPStatusCode.forbidden))
        interactor.fetchRepositoryData(for: "Swift")
        XCTAssertEqual(1, presenter.dataFetchedErrorCounter)
    }
}
