//
//  RepoDetailInteractor.swift
//  Find_Post
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
import CloudServices

class RepoDetailInteractor: RepoDetailPresenterToInteractorProtocol {
    weak var presenter: RepoDetailInteractorToPresenterProtocol?
    var cloudRepo: ICloudRepo = CloudRepo()
    var dataSource: SearchItem?
    
    ///  Reponsible for getting data from the API
    func fetchAndSendRepoDetailData() {
        if let dataSource = dataSource {
            presenter?.getSuccessResponse(data: dataSource)
            self.fetchComments(for: dataSource.id)
        }
    }

    func fetchComments(for id: Int?) {
        guard let id = id else {
            return
        }

        cloudRepo.getComments(for: String(id)) { [weak self] result in
            guard let self = self else {
                self?.presenter?.commentFetchedError(error: ServiceError.badData)
                return
            }
            switch result {
            case let .failure(serviceError):
                self.presenter?.commentFetchedError(error: serviceError)

            case let .success(response):
                self.presenter?.commentSuccessResponse(data: response)
            }
        }
    }
}
