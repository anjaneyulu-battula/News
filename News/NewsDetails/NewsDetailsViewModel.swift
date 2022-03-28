//
//  NewsDetailsViewModel.swift
//  News
//
//  Created by Anjaneyulu Battula on 27/03/22.
//

import Foundation

class NewsDetailsViewModel {
    let newsAPIModel: NewsRowViewModel!

    init(newsAPIModel: NewsRowViewModel) {
        self.newsAPIModel = newsAPIModel
    }

    var urlRequest: URLRequest {
        let url = URL(string: newsAPIModel.url!)!
        let urlRequest = URLRequest.init(url: url)
        return urlRequest
    }
}
