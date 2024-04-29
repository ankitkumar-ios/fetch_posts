//
//  MockRepoDetailViewController.swift
//  Find_Post
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
@testable import Find_Post
@testable import CloudServices

class MockRepoDetailViewController: RepoDetailPresenterToViewProtocol {
    var presenter: RepoDetailViewToPresenterProtocol?

    var populateRepoDataCounter = 0
    func populateRepoData(data: CloudServices.Items) {
        populateRepoDataCounter += 1
    }
}
