//
//  NewsListViewModel.swift
//  News
//
//  Created by Anjaneyulu Battula on 27/03/22.
//

import Foundation
import Combine
import UIKit

enum NewsListUpdateStatus {
    case success
    case failure(msg: String)
}

class NewsListViewModel {
    typealias NewsListUpdate = (NewsListUpdateStatus) -> Void
    var newsListUpdate: NewsListUpdate!
    var email: String!

    var dataSource = [NewsRowViewModel]()
    var selectedIndexPath: IndexPath?

    private var disposables = Set<AnyCancellable>()

    init(email: String) {
        self.email = email
    }

    func fetchReadNewsList() {
        DBManager.shared.getNewsListWith(email: email) { [weak self] result
            in

            guard let weakSelf = self else { return }

            switch result {
            case .success(let readNewsDBList):
                weakSelf.fetchNewsList(readNewsDBList: readNewsDBList)
            case .failure(let errorDetails):
                weakSelf.newsListUpdate(.failure(msg: errorDetails.msg))
            }
        }
    }

    func fetchNewsList(readNewsDBList: [NewsDB]?) {

        APIManager.shared.getNewsList()
            .map { response in
                response.hits.map { item in
                    return NewsRowViewModel.init(points: item.points,
                                                 title: item.title,
                                                 url: item.url,
                                                 newsObjectID: item.newsObjectID,
                                                 createdAt: item.createdAt,
                                                 isFromTodayColor: ((Date().removeTimeStamp ?? Date()) <= item.createdAt ? .red : .black),
                                                 isReadColor: ((readNewsDBList?.filter { $0.newsObjectId == item.newsObjectID } ?? []).isEmpty ? .white : .lightGray.withAlphaComponent(0.5)))
                }
            }
            .receive(on: DispatchQueue.main, options: nil)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let weakSelf = self else { return }
                    switch value {
                    case .finished:
                        break
                    case .failure(let errorDetails):
                        weakSelf.dataSource = []
                        weakSelf.newsListUpdate(.failure(msg: errorDetails.msg))
                    }

                }, receiveValue: { [weak self] newsList in
                    guard let weakSelf = self else { return }
                    weakSelf.dataSource = newsList
                    weakSelf.newsListUpdate(.success)
            })
            .store(in: &disposables)
    }

    func updateArticleAsRead() {
        if let selectedIndexPath = selectedIndexPath {
            let rowViewModel = dataSource[selectedIndexPath.row]
            rowViewModel.isReadColor = .lightGray.withAlphaComponent(0.5)
//                dataSource[selectedIndexPath.row] = rowViewModel
        }
    }

}
