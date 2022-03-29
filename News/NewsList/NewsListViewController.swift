//
//  NewsListViewController.swift
//  News
//
//  Created by Anjaneyulu Battula on 27/03/22.
//

import UIKit
import Combine

protocol NewsListViewControllerDelegate: AnyObject {

    func markArticleAsRead()
}

class NewsListViewController: UIViewController {

    private var disposables = Set<AnyCancellable>()
    var viewModel: NewsListViewModel!

    @IBOutlet weak var newsListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        newsListTableView.dataSource = self
        newsListTableView.delegate = self

        registerNewsListUpdate()
        startFetchNewsList()
    }

    private func registerNewsListUpdate() {
        viewModel.newsListUpdate = { [weak self] status in
            guard let weakSelf = self else { return }
            Utility.shared.hideLoader(viewController: weakSelf)
            switch status {
            case .success:
                weakSelf.newsListTableView.reloadData()
            case .failure(let msg):
                Utility.shared.showAlert(viewController: weakSelf, msg: msg)
            }
        }
    }

    private func startFetchNewsList() {
        Utility.shared.showLoader(viewController: self)
        viewModel.fetchReadNewsList()
    }

    @IBAction func logoutAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

// MARK: - UITableViewDataSource
extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsListTableCell = tableView.dequeueReusableCell(withIdentifier: "NewsListTableCell") as? NewsListTableCell else {
            return UITableViewCell()
        }
        newsListTableCell.configure(newsRowViewModel: viewModel.dataSource[indexPath.row])
        return newsListTableCell
    }
}

// MARK: - UITableViewDelegate
extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let newsRowViewModel = viewModel.dataSource[indexPath.row]
        guard let _ = newsRowViewModel.url else {
            Utility.shared.showAlert(viewController: self, msg: "URL is not available for this news article. Please try another one")
            return
        }
        viewModel.selectedIndexPath = indexPath
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let newsDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
        newsDetailsViewController.delegate = self
        newsDetailsViewController.viewModel = NewsDetailsViewModel(email: viewModel.email,
                                                                   newsRowViewModel: newsRowViewModel)
        self.navigationController?.pushViewController(newsDetailsViewController, animated: true)
    }
}

// MARK: - NewsListViewControllerDelegate
extension NewsListViewController: NewsListViewControllerDelegate {
    
    func markArticleAsRead() {
        viewModel.updateArticleAsRead()
        if let selectedIndexPath = viewModel.selectedIndexPath {
            newsListTableView.reloadRows(at: [selectedIndexPath], with: .none)
        }
    }
}
