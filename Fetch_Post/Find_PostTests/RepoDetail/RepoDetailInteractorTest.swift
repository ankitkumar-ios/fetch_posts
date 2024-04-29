//
//  RepoDetailInteractorTest.swift
//  Find_PostTests
//
//  Created by Ankit Kumar on 29/04/24.
//

import XCTest
@testable import CloudServices
@testable import Find_Post

final class RepoDetailInteractorTest: XCTestCase {
    func test_getSuccessResponse_called() throws {
        let interactor = RepoDetailInteractor()
        let presenter = MockRepoDetailPresenter()
        interactor.presenter = presenter
        
        var data = Items()
        data.id = 1
        interactor.dataSource = data

        interactor.fetchAndSendRepoDetailData()
        XCTAssertEqual(1, presenter.successResponseCounter)
        XCTAssertEqual(presenter.data?.id, data.id)
    }

    func test_getSuccessResponse_withNilData() throws {
        let interactor = RepoDetailInteractor()
        let presenter = MockRepoDetailPresenter()
        interactor.presenter = presenter

        interactor.dataSource = nil

        interactor.fetchAndSendRepoDetailData()
        XCTAssertEqual(0, presenter.successResponseCounter)
        XCTAssertNil(presenter.data)
    }
}

class MockRepoDetailPresenter: RepoDetailInteractorToPresenterProtocol {
    var data: Items? = nil
    var successResponseCounter = 0
    func getSuccessResponse(data: CloudServices.Items) {
        successResponseCounter += 1
        self.data = data
    }
}
