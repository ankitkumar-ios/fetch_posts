//
//  DashboardRouter.swift
//  Find_Post
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
import CloudServices

class DashboardRouter: DashboardPresenterToRouterProtocol {
    func mainstoryboard() -> UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    /// Responsible for creating and initializing the DashboardViewController module and it's instance
    /// - Returns: DashboardViewController
    func createModule() -> DashboardViewController {
        let view = mainstoryboard().instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        let presenter: DashboardViewToPresenterProtocol & DashboardIntractorToPresenterProtocol = DashboardPresenter()
        var interactor: DashboardPresenterToInteractorProtocol = DashboardIntractor()
        let router: DashboardPresenterToRouterProtocol = DashboardRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
    }

    func pushToRepositoryDetailViewController(navigationController: UINavigationController?, itemData: SearchItem) {
        let repoDetailVC = RepoDetailRouter().createModule(data: itemData)
        navigationController?.pushViewController(repoDetailVC, animated: true)
    }

}
