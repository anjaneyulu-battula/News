//
//  NewsListViewController.swift
//  News
//
//  Created by Anjaneyulu Battula on 27/03/22.
//

import UIKit
import Combine

class NewsListViewController: UIViewController {

    private var disposables = Set<AnyCancellable>()
    let viewModel = NewsListViewModel()

    @IBOutlet weak var newsListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.title = "H4XOR NEWS"

        newsListTableView.dataSource = self
        newsListTableView.delegate = self

        fetchNewsList()
    }

    private func fetchNewsList() {
        viewModel.fetchNewsList()

        viewModel.$dataSource
            .receive(on: DispatchQueue.main, options: nil)
            .sink { [weak self] _ in
                guard let weakSelf = self else { return }
                weakSelf.newsListTableView.reloadData()
            }
            .store(in: &disposables)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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

        newsListTableCell.configure(newsAPIModel: viewModel.dataSource[indexPath.row])
        return newsListTableCell
    }
}

// MARK: - UITableViewDelegate
extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let newsDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
        newsDetailsViewController.viewModel = NewsDetailsViewModel(newsAPIModel: viewModel.dataSource[indexPath.row])
        self.navigationController?.pushViewController(newsDetailsViewController, animated: true)
    }
}
