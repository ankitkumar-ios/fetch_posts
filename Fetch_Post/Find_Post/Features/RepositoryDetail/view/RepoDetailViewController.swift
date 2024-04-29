//
//  RepoDetailViewController.swift
//  Find_Post
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
import CloudServices

class RepoDetailViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var aboutLabel: UILabel!

    @IBOutlet var topDetailContainerView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    var presenter: RepoDetailViewToPresenterProtocol?
    var dataSource: CommentResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTableView()
        activityIndicator.startAnimating()
        presenter?.startFetchingRepoDetailData()
    }

    private func setupTableView() {
        tableView.separatorStyle = .singleLine
    }

    private func setupLayout() {
        topDetailContainerView.clipsToBounds = true
        topDetailContainerView.layer.cornerRadius = 20
        topDetailContainerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}

extension RepoDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as? CommentTableViewCell else {
            return UITableViewCell()
        }

        cell.configureCell(data: dataSource?.items?[indexPath.row])
        return cell
    }
}

extension RepoDetailViewController: RepoDetailPresenterToViewProtocol {

    /// Responsible for populating the data to the UI components
    /// - Parameter data: Items i.e. RepoDetail
    func populateRepoData(data: SearchItem) {
        DispatchQueue.main.async { [weak self] in
            self?.nameLabel.text = data.title
            self?.fullNameLabel.text = AppConstants.ID + String(data.id ?? 0)
            self?.aboutLabel.text = data.body
        }
    }

    func populateComment(data: CommentResponse?) {
        dataSource = data
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.tableView.reloadData()
        }
    }
}
