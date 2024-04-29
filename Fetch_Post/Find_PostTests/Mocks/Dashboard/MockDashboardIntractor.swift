//
//  MockDashboardIntractor.swift
//  Find_Post
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
@testable import Find_Post
@testable import CloudServices

class MockDashboardIntractor: DashboardPresenterToInteractorProtocol {
    var presenter: DashboardIntractorToPresenterProtocol?

    var fetchRepositoryDataCounter = 0
    func fetchRepositoryData(for query: String) {
        fetchRepositoryDataCounter += 1
    }
}
