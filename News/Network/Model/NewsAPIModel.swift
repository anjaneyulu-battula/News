//
//  NewsAPIModel.swift
//  News
//
//  Created by Anjaneyulu Battula on 27/03/22.
//

import Foundation

struct NewsAPIModel: Codable {
    var points: Int
    var url: String?
    var title: String
    var createdAt: Date

    private enum DecodingKeys: String, CodingKey {
        case points
        case url
        case title
        case createdAt = "created_at"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        self.points = try container.decode(Int.self, forKey: .points)
        self.url = try container.decode(String.self, forKey: .url)
        self.title = try container.decode(String.self, forKey: .title)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
    }
}
