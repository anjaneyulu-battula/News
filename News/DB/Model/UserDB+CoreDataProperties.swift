//
//  UserDB+CoreDataProperties.swift
//  News
//
//  Created by Anjaneyulu Battula on 29/03/22.
//
//

import Foundation
import CoreData


extension UserDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDB> {
        return NSFetchRequest<UserDB>(entityName: "UserDB")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var news: NSSet?
}

// MARK: Generated accessors for news
extension UserDB {

    @objc(addNewsObject:)
    @NSManaged public func addToNews(_ value: NewsDB)

    @objc(removeNewsObject:)
    @NSManaged public func removeFromNews(_ value: NewsDB)

    @objc(addNews:)
    @NSManaged public func addToNews(_ values: NSSet)

    @objc(removeNews:)
    @NSManaged public func removeFromNews(_ values: NSSet)

}

extension UserDB : Identifiable {

}
