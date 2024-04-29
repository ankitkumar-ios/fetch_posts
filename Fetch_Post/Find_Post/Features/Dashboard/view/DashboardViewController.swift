//
//  DashboardViewController.swift
//  Find_Post
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
import CloudServices

class DashboardViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var resultTitle: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    var presenter: DashboardViewToPresenterProtocol?
    var dataSource: SearchResponse? = nil

    override func viewDidLoad() {
        setupNavigation()
        setupCollectionView()
        setupTexts()
        setupActivityIndicator()
    }

    private func setupNavigation() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = AppConstants.empty
    }

    private func setupCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.backgroundColor = .clear
    }

    private func setupTexts() {
        self.resultTitle.text = AppConstants.startFetchingPost
    }

    func setupActivityIndicator() {
        activityIndicator.color = .white
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        resultTitle.text = AppConstants.gettingNewResults
        activityIndicator.startAnimating()
        presenter?.startFetchingRepositoryData(for: "")
    }
}

// MARK: - Refresh Data
extension DashboardViewController: DashboardPresenterToViewProtocol {
    func showSearchResult(response: SearchResponse) {
        dataSource = response
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.activityIndicator.stopAnimating()
            if response.items != nil {
                self.resultTitle.text = String(self.dataSource?.items?.count ?? 0) + AppConstants.space + AppConstants.matchingResults
            } else {
                self.resultTitle.text = AppConstants.couldNotFindData
            }
            self.collectionView.reloadData()
        }
    }

    func showError(errorMessage: String) {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.resultTitle.text = errorMessage
            self?.dataSource = nil
            self?.collectionView.reloadData()
        }
    }
}


// MARK: - Collection View
extension DashboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.items?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: RepositoryCollectionViewCell.self),
            for: indexPath
        ) as? RepositoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(
            subTitle: AppConstants.ID + String(dataSource?.items?[indexPath.row].id ?? 0),
            title: dataSource?.items?[indexPath.row].title,
            about: dataSource?.items?[indexPath.row].body
        )
        return cell

    }
}

extension DashboardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let width = screenWidth / 2 - 20

        return CGSize(width: width, height: 190)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}

extension DashboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource?.items?[indexPath.row] else {
            return
        }
        presenter?.showRepositoryDetailViewController(navigationController: navigationController, detail: item)
    }
}
