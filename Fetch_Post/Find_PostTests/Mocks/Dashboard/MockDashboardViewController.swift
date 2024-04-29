//
//  MockDashboardViewController.swift
//  Find_Post
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
@testable import Find_Post
@testable import CloudServices

class MockDashboardViewController: DashboardPresenterToViewProtocol {
    var presenter: DashboardViewToPresenterProtocol?

    var showSearchResultCounter = 0
    func showSearchResult(response: SearchResponse) {
        showSearchResultCounter += 1
    }

    var actualErrorMessage: String?
    func showError(errorMessage: String) {
        self.actualErrorMessage = errorMessage
    }
}
