//
//  DashboardViewModel.swift
//  Find_Post
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
import CloudServices

protocol DashboardViewModelProtocol: AnyObject {
    func updateUI()
}

// ViewModel is not needed as we are not doing any processing
// Not using this class

class DashboardViewModel {
    var presenter: DashboardPresenter?
    weak var delegate: DashboardViewModelProtocol?

    init(presenter: DashboardPresenter? = nil) {
        self.presenter = presenter
    }

    func getData(for query: String) {
        presenter?.startFetchingRepositoryData(for: query)
    }
}
