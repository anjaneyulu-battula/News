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

    let email: String!
    let newsRowViewModel: NewsRowViewModel!

    init(email: String, newsRowViewModel: NewsRowViewModel) {
        self.email = email
        self.newsRowViewModel = newsRowViewModel
    }

    var urlRequest: URLRequest? {
        guard let urlStr = newsRowViewModel.url, let url = URL(string: urlStr) else {
            return nil
        }
        let urlRequest = URLRequest.init(url: url)
        return urlRequest
    }

    func updateDetails() {
        DBManager.shared.getUserWith(email: email) { result in
            switch result {
            case .success(let userDB):
                newsDetailsUpdate(.success)
                insertReadNews(userDB: userDB)
            case .failure(let errorDetails):
                newsDetailsUpdate(.failure(msg: errorDetails.msg))
            }
        }
    }

    func insertReadNews(userDB: UserDB?) {
        DBManager.shared.insertNewsWith(email: email ,newsModel: newsRowViewModel) { [weak self] result in
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
