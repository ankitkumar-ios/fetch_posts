//
//  MockRepoDetailInteractor.swift
//  Find_Post
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
@testable import Find_Post
@testable import CloudServices

class MockRepoDetailIntractor: RepoDetailPresenterToInteractorProtocol {
    var dataSource: CloudServices.Items?
    var presenter: RepoDetailInteractorToPresenterProtocol?

    var fetchAndSendRepoDetailDataCounter = 0
    func fetchAndSendRepoDetailData() {
        fetchAndSendRepoDetailDataCounter += 1
    }
}
