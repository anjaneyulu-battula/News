//
//  NewsListViewModel.swift
//  News
//
//  Created by Anjaneyulu Battula on 27/03/22.
//

import Foundation
import Combine

class NewsListViewModel {
    @Published var dataSource = [NewsRowViewModel]()

    private var disposables = Set<AnyCancellable>()

    init() {}

    func fetchNewsList() {

        APIManager.shared.getNewsList()
            .map { response in
                response.hits.map(NewsRowViewModel.init)
            }
            .receive(on: DispatchQueue.main, options: nil)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let weakSelf = self else { return }
                    switch value {
                    case .finished:
                        break
                    case .failure:
//                        print(error.localizedDescription)
                        weakSelf.dataSource = []
                    }

                }, receiveValue: { [weak self] newsList in
                    guard let weakSelf = self else { return }
                    weakSelf.dataSource = newsList
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
