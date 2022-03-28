//
//  NewsListViewModel.swift
//  News
//
//  Created by Anjaneyulu Battula on 27/03/22.
//

import Foundation
import Combine

enum NewsListUpdateStatus {
    case success
    case failure(msg: String)
}

class NewsListViewModel {
    typealias NewsListUpdate = (NewsListUpdateStatus) -> Void
    var newsListUpdate: NewsListUpdate!

    var dataSource = [NewsRowViewModel]()

    private var disposables = Set<AnyCancellable>()

    init() {}

    func fetchReadNewsList() {
        DBManager.shared.getNewsListWith(email: Utility.shared.email) { [weak self] result
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
        //TODO :Add required data here
//        guard dataSource.isEmpty else {
//
//        }

        APIManager.shared.getNewsList()
            .map { response in
                response.hits.map { item in
                    return NewsRowViewModel.init(item: item,
                                          readNewsDBList: readNewsDBList)
                }
//                response.hits.map(NewsRowViewModel.init)
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

        /*
        APIManager.shared.getNewsList()
            .receive(on: DispatchQueue.main)
            .map{ $0 }
            .sink { completion in
                switch completion {
                case .finished:
                    print("Done")
                case .failure(let error):
                    print("error")
                }
            } receiveValue: { [weak self] newsList in
                guard let weakSelf = self else { return }
                weakSelf.newsList = newsList
            }
            .store(in: &anyCancellable)*/
    }

}
