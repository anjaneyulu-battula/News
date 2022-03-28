//
//  NewsDB+CoreDataProperties.swift
//  News
//
//  Created by Anjaneyulu Battula on 29/03/22.
//
//

import Foundation
import CoreData


extension NewsDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsDB> {
        return NSFetchRequest<NewsDB>(entityName: "NewsDB")
    }

    @NSManaged public var newsObjectId: String?
    @NSManaged public var points: Int16
    @NSManaged public var url: String?
    @NSManaged public var title: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var news: UserDB?

}

extension NewsDB : Identifiable {

}
