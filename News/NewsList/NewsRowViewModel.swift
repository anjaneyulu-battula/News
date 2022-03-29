//
//  NewsRowViewModel.swift
//  News
//
//  Created by Anjaneyulu Battula on 28/03/22.
//

import Foundation
import UIKit

struct NewsRowViewModel {

    var points: Int
    var title: String
    var url: String?
    var newsObjectID: String
    var createdAt: Date
    var isFromTodayColor: UIColor
    var isRead: Bool

    init(points: Int,
         title: String,
         url: String?,
         newsObjectID: String,
         createdAt: Date,
         isFromTodayColor: UIColor,
         isRead: Bool = false) {
        self.points = points
        self.title = title
        self.url = url
        self.newsObjectID = newsObjectID
        self.createdAt = createdAt
        self.isFromTodayColor = isFromTodayColor
        self.isRead = isRead
    }
}
