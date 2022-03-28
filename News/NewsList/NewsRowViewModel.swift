//
//  NewsRowViewModel.swift
//  News
//
//  Created by Anjaneyulu Battula on 28/03/22.
//

import Foundation
import UIKit

struct NewsRowViewModel {
    private let item: NewsListResponse.Item
    private let readNewsDBList: [NewsDB]?

    init(item: NewsListResponse.Item, readNewsDBList: [NewsDB]?) {
        self.item = item
        self.readNewsDBList = readNewsDBList
    }

    var points: Int {
        return item.points
    }

    var title: String {
        return item.title
    }

    var url: String? {
        return item.url
    }

    var newsObjectID: String {
        return item.newsObjectID
    }

    var createdAt: Date {
        return item.createdAt
    }

    var isFromTodayColor: UIColor {
        print(" \(item.points) :::createdAt: \(item.createdAt) ::: \(Date().removeTimeStamp)")
        return (Date().removeTimeStamp ?? Date()) <= item.createdAt ? .red : .darkGray
    }

    var isRead: Bool {

        if let readNewsList = readNewsDBList?.filter { $0.newsObjectId == item.newsObjectID }, readNewsList.isEmpty == false {
            return true
        } else {
            return false
        }

//        if let readNewsList =  readNewsDBList?.filter({ $0.newsObjectId == item.newsObjectID }) {
//            return true
//        } else {
//            return false
//        }
    }

}
