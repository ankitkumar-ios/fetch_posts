//
//  DashboardPresenterTest.swift
//  Find_PostTests
//
//  Created by Ankit Kumar on 29/04/24.
//

import XCTest
@testable import CloudServices
@testable import Find_Post

final class DashboardPresenterTest: XCTestCase {
    func test_repositoryDataFetchedSuccess_called() throws {
        let presenter = DashboardPresenter()
        let view = MockDashboardViewController()

        view.presenter = presenter
        presenter.view = view
        
        presenter.repositoryDataFetchedSuccess(response: SearchResponse())
        XCTAssertEqual(1, view.showSearchResultCounter)
    }

    func test_startFetchingRepoDat_called() throws {
        let presenter = DashboardPresenter()
        let interactor = MockDashboardIntractor()

        presenter.interactor = interactor
        interactor.presenter = presenter

        presenter.startFetchingRepositoryData(for: "Swift")
        XCTAssertEqual(1, interactor.fetchRepositoryDataCounter)
    }

    func test_showRepositoryDetailViewController_called() throws {
        let presenter = DashboardPresenter()
        let router = MockDashboardRouter()

        presenter.router = router

        presenter.showRepositoryDetailViewController(navigationController: nil, detail: Items())
        XCTAssertEqual(1, router.pushCounter)
    }

    func test_errorMessages() throws {
        let presenter = DashboardPresenter()
        let view = MockDashboardViewController()
        view.presenter = presenter
        presenter.view = view

        func verify(error: ServiceError, expectedErrorMessage: String) {
            presenter.repositoryDataFetchedError(error: error)
            XCTAssertEqual(expectedErrorMessage, view.actualErrorMessage)
        }

        verify(error: .noInternet, expectedErrorMessage: AppConstants.noInternetConnection)
        verify(error: .badData, expectedErrorMessage: AppConstants.badData)
        verify(error: .invalidURL, expectedErrorMessage: AppConstants.invalidUrl)
        verify(error: .responseError(code: .notFound), expectedErrorMessage: AppConstants.notFound)
        verify(error: .responseError(code: .badRequest), expectedErrorMessage: AppConstants.badRequest)
        verify(error: .responseError(code: .unauthorized), expectedErrorMessage: AppConstants.unauthorized)
        verify(error: .responseError(code: .forbidden), expectedErrorMessage: AppConstants.forbidden)
        verify(error: .responseError(code: .notFound), expectedErrorMessage: AppConstants.notFound)
        verify(error: .responseError(code: .internalServerError), expectedErrorMessage: AppConstants.internalServiceError)
        verify(error: .responseError(code: .couldNotFindData), expectedErrorMessage: AppConstants.couldNotFindData)
    }
}
