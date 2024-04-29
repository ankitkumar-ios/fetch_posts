//
//  RepoDetailPresenterTest.swift
//  Find_PostTests
//
//  Created by Ankit Kumar on 29/04/24.
//

import XCTest
@testable import CloudServices
@testable import Find_Post

final class RepoDetailPresenterTest: XCTestCase {
    func test_populateRepoDataCounter_called() throws {
        let presenter = RepoDetailPresenter()
        let view = MockRepoDetailViewController()

        view.presenter = presenter
        presenter.view = view

        presenter.getSuccessResponse(data: Items())
        XCTAssertEqual(1, view.populateRepoDataCounter)
    }

    func test_populateRepoDataCounter_called1() throws {
        let presenter = RepoDetailPresenter()
        let interactor = MockRepoDetailIntractor()

        interactor.presenter = presenter
        presenter.interactor = interactor

        presenter.startFetchingRepoDetailData()
        XCTAssertEqual(1, interactor.fetchAndSendRepoDetailDataCounter)
    }
}
