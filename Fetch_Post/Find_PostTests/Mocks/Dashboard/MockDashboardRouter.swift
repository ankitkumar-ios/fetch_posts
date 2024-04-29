//
//  MockDashboardRouter.swift
//  Find_PostTests
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
@testable import Fetch
@testable import CloudServices

class MockDashboardRouter: DashboardPresenterToRouterProtocol {
    func createModule() -> DashboardViewController {
        // not needed
        return DashboardViewController()
    }

    var pushCounter = 0
    func pushToRepositoryDetailViewController(navigationController: UINavigationController?, itemData: CloudServices.Items) {
        pushCounter += 1
    }
}


