//
//  NewsRowViewModel.swift
//  News
//
//  Created by Anjaneyulu Battula on 28/03/22.
//

import Foundation
import UIKit
import Combine

class NewsRowViewModel: ObservableObject {

    var points: Int
    var title: String
    var url: String?
    var newsObjectID: String
    var createdAt: Date
    var isReadColor: UIColor
    @Published var isFromTodayColor: UIColor

    init(points: Int,
         title: String,
         url: String?,
         newsObjectID: String,
         createdAt: Date,
         isFromTodayColor: UIColor,
         isReadColor: UIColor = .white) {

        print(" \(points) :::createdAt: \(createdAt) ::: \(String(describing: Date().removeTimeStamp))")

        self.points = points
        self.title = title
        self.url = url
        self.newsObjectID = newsObjectID
        self.createdAt = createdAt
        self.isFromTodayColor = isFromTodayColor
        self.isReadColor = isReadColor
    }
}
