//
//  DBManager.swift
//  News
//
//  Created by Anjaneyulu Battula on 29/03/22.
//

import Foundation
import CoreData

class DBManager {

    private init() {}
    static let shared = DBManager()

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "News")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext(completion: (Result<Void, NewsError>) -> Void) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(.success(()))
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                print("\(error.localizedDescription)")
                completion(.failure(.coredata(description: "\(error.localizedDescription)")))
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // Inserting User
    func insertUser(email: String,
                    password: String,
                    completion: (Result<Void, NewsError>) -> Void) {
        let userDB = UserDB(context: persistentContainer.viewContext)
        userDB.email = email
        userDB.password = password
        saveContext(completion: completion)
    }

    // Get User
    func getUserWith(email: String, completion: (Result<UserDB?, NewsError>) -> Void) {
        let fetchRequest = UserDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email LIKE %@", email)

        do {
            if let userDB = try persistentContainer.viewContext.fetch(fetchRequest).first {
                completion(.success(userDB))
            } else {
                completion(.success(nil))
            }
        } catch {
            completion(.failure(.coredata(description: "Get userdata error")))
        }
    }

    // Inserting News
    func insertNewsWith(email: String, newsModel: NewsRowViewModel,
                    completion: (Result<Void, NewsError>) -> Void) {
        getUserWith(email: email) { result in
            switch result {
            case .success(let userDB):
                if let news = userDB?.news?.allObjects  as? [NewsDB], news.filter({ $0.newsObjectId == newsModel.newsObjectID }).isEmpty {

                    let newsDB = NewsDB(context: persistentContainer.viewContext)
                    newsDB.newsObjectId = newsModel.newsObjectID
                    newsDB.points = Int16(newsModel.points)
                    newsDB.title = newsModel.title
                    newsDB.url = newsModel.url
                    newsDB.createdAt = newsModel.createdAt

                    userDB?.addToNews(newsDB)
                    saveContext(completion: completion)
                }
                completion(.success(()))
            case .failure(let errorDetails):
                completion(.failure(errorDetails))
            }
        }
    }

    // Get NewsList
    func getNewsListWith(email: String, completion: (Result<[NewsDB]?, NewsError>) -> Void) {
        let fetchRequest = UserDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email LIKE %@", email)

        do {
            if let userDB = try persistentContainer.viewContext.fetch(fetchRequest).first, let newsDBList = userDB.news?.allObjects as? [NewsDB] {
                completion(.success(newsDBList))
            } else {
                completion(.success(nil))
            }
        } catch {
            completion(.failure(.coredata(description: "Get userdata error")))
        }
    }
}
