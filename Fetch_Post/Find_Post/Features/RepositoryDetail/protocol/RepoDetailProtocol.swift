//
//  RepoDetailProtocol.swift
//  Find_Post
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
import CloudServices

/// Used for the communication from view to presenter
protocol RepoDetailViewToPresenterProtocol: AnyObject {
    var view: RepoDetailPresenterToViewProtocol? {get set}
    var router: RepoDetailPresenterToRouterProtocol? {get set}
    var interactor: RepoDetailPresenterToInteractorProtocol? {get set}
    func startFetchingRepoDetailData()
}

/// Used for the communication from presenter to view
protocol RepoDetailPresenterToViewProtocol: AnyObject {
    var presenter: RepoDetailViewToPresenterProtocol? {get set}
    func populateRepoData(data: SearchItem)
    func populateComment(data: CommentResponse?)
}

/// Used for the communication from presenter to router
protocol RepoDetailPresenterToRouterProtocol {
    func createModule(data: SearchItem) -> RepoDetailViewController
}

/// Used for the communication from presenter to interactor
protocol RepoDetailPresenterToInteractorProtocol: AnyObject {
    var dataSource: SearchItem? {get set}
    var presenter: RepoDetailInteractorToPresenterProtocol? {get set}
    func fetchAndSendRepoDetailData()
}

/// Used for the communication from interactor to presenter
protocol RepoDetailInteractorToPresenterProtocol: AnyObject {
    func getSuccessResponse(data: SearchItem)
    func commentSuccessResponse(data: CommentResponse)
    func commentFetchedError(error: ServiceError)
}
