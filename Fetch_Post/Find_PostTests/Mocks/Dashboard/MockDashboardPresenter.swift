//
//  MockDashboardPresenter.swift
//  Find_PostTests
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
@testable import Find_Post
@testable import CloudServices

class MockDashboardPresenter: DashboardIntractorToPresenterProtocol, DashboardViewToPresenterProtocol {
    var view: Find_Post.DashboardPresenterToViewProtocol?
    var interactor: Find_Post.DashboardPresenterToInteractorProtocol?
    var router: Find_Post.DashboardPresenterToRouterProtocol?

    func startFetchingRepositoryData(for query: String) {
        // Not needed
    }

    func showRepositoryDetailViewController(navigationController: UINavigationController?, detail: CloudServices.Items) {
        // Not needed
    }

    var dataFetchedSuccessCounter = 0
    func repositoryDataFetchedSuccess(response: CloudServices.SearchResponse) {
        dataFetchedSuccessCounter += 1
    }
    
    var dataFetchedErrorCounter = 0
    func repositoryDataFetchedError(error: CloudServices.ServiceError) {
        dataFetchedErrorCounter += 1
    }
}

