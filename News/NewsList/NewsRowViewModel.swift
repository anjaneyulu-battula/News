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

    init(item: NewsListResponse.Item) {
      self.item = item
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

    var isFromTodayColor: UIColor {
        print(" \(item.points) :::createdAt: \(item.createdAt) ::: \(Date().removeTimeStamp)")
        return (Date().removeTimeStamp ?? Date()) <= item.createdAt ? .red : .darkGray
    }

}
