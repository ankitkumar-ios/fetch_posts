//
//  RepoDetailPresenter.swift
//  Find_Post
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
import CloudServices

class RepoDetailPresenter: RepoDetailViewToPresenterProtocol {
    weak var view: RepoDetailPresenterToViewProtocol?
    var router: RepoDetailPresenterToRouterProtocol?
    var interactor: RepoDetailPresenterToInteractorProtocol?
    
    /// View calling presenter for start fetching the data
    func startFetchingRepoDetailData() {
        interactor?.fetchAndSendRepoDetailData()
    }
}

extension RepoDetailPresenter: RepoDetailInteractorToPresenterProtocol {

    /// Responsible for sending data to the view
    /// - Parameter data: Items i.e. SearchItem
    func getSuccessResponse(data: SearchItem) {
        view?.populateRepoData(data: data)
    }

    /// Responsible for sending data to the view
    /// - Parameter data: Items i.e. CommentResponse
    func commentSuccessResponse(data: CommentResponse) {
        view?.populateComment(data: data)
    }

    func commentFetchedError(error: ServiceError) {
        view?.populateComment(data: nil)
    }
}
