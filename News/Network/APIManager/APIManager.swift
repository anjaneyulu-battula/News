//
//  APIManager.swift
//  News
//
//  Created by Anjaneyulu Battula on 27/03/22.
//

import Foundation
import Combine

enum NewsError: Error {
    case parsing(description: String)
    case network(description: String)
    case coredata(description: String)

    var msg: String {
        switch self {
        case .parsing(let description):
            return description
        case .network(let description):
            return description
        case .coredata(let description):
            return description
        }
    }
}

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, NewsError> {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(dateFormatter)

    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
        .parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
}

final class APIManager {

    static let shared = APIManager()
    private let session: URLSession
    var anyCancelable = Set<AnyCancellable>()


    private init(session: URLSession = .shared) {
        self.session = session
    }

    func getNewsList() -> AnyPublisher<NewsListResponse, NewsError> {

        let urlString = "http://hn.algolia.com/api/v1/search?tags=front_page"
        guard let url = URL(string: urlString) else {
          let error = NewsError.network(description: "Couldn't create URL")
          return Fail(error: error).eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}
