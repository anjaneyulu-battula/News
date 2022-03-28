//
//  NewsDetailsViewModel.swift
//  News
//
//  Created by Anjaneyulu Battula on 27/03/22.
//

import Foundation

enum NewsDetailsUpdateStatus {
    case success
    case failure(msg: String)
}

class NewsDetailsViewModel {

    typealias NewsDetailsUpdate = (NewsDetailsUpdateStatus) -> Void
    var newsDetailsUpdate: NewsDetailsUpdate!

    let newsRowViewModel: NewsRowViewModel!

    init(newsAPIModel: NewsRowViewModel) {
        self.newsRowViewModel = newsAPIModel
    }

    var urlRequest: URLRequest {
        let url = URL(string: newsRowViewModel.url!)!
        let urlRequest = URLRequest.init(url: url)
        return urlRequest
    }

    func updateDetails() {
        DBManager.shared.getUserWith(email: Utility.shared.email) { result in
            switch result {
            case .success(let userDB):
                insertReadNews(userDB: userDB)

            case .failure(let errorDetails):
                newsDetailsUpdate(.failure(msg: errorDetails.msg))
            }
        }
    }

    func insertReadNews(userDB: UserDB?) {
        DBManager.shared.insertNewsWith(email: Utility.shared.email ,newsModel: newsRowViewModel) { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case .success():
                break
            case .failure(let errorDetails):
                weakSelf.newsDetailsUpdate(.failure(msg: errorDetails.msg))
            }
        }
    }
}
