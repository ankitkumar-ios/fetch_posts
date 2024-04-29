//
//  DashboardPresenter.swift
//  Fetch_Post
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
import CloudServices

class DashboardPresenter: DashboardViewToPresenterProtocol {
    weak var view: DashboardPresenterToViewProtocol?
    var interactor: DashboardPresenterToInteractorProtocol?
    var router: DashboardPresenterToRouterProtocol?
    
    /// Responsible for fetching the data from interactor
    /// - Parameter query: String
    func startFetchingRepositoryData(for query: String) {
        interactor?.fetchRepositoryData(for: query)
    }
    
    /// Responsbile for opening the RepositoryDetailViewController
    /// - Parameters:
    ///   - navigationController: UINavigationController
    ///   - detail: Items
    func showRepositoryDetailViewController(navigationController: UINavigationController?, detail: SearchItem) {
        router?.pushToRepositoryDetailViewController(navigationController: navigationController, itemData: detail)
    }
}

extension DashboardPresenter: DashboardIntractorToPresenterProtocol {
    func repositoryDataFetchedSuccess(response: SearchResponse) {
        view?.showSearchResult(response: response)
    }
    
    /// Responsbile for paring the error and send the error message to the DashbaordViewController
    /// - Parameter error: ServiceError
    func repositoryDataFetchedError(error: ServiceError) {
        var message = AppConstants.badData

        switch error {
        case .badData:
            message = AppConstants.badData
        case .noInternet:
            message = AppConstants.noInternetConnection
        case .invalidURL:
            message = AppConstants.invalidUrl
        case .serviceError(error: let error):
            message = "Got error: " + error.localizedDescription
        case .responseError(code: let code):
            switch code {
            case .ok:
                break;
            case .couldNotFindData:
                message = AppConstants.couldNotFindData
            case .badRequest:
                message = AppConstants.badRequest
            case .unauthorized:
                message = AppConstants.unauthorized
            case .forbidden:
                message = AppConstants.forbidden
            case .notFound:
                message = AppConstants.notFound
            case .internalServerError:
                message = AppConstants.internalServiceError
            }
        }
        view?.showError(errorMessage: message)
    }
}

