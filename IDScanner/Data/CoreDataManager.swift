//
//  CoreDataManager.swift
//  IDScanner
//
//  Created by Kovalev Gleb on 01.10.2024.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        print("Successfully loaded container")
        return container
    }()

    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func save() throws {
        if viewContext.hasChanges {
            try viewContext.save()
        }
    }

    func fetchHistory() -> [DriverIDHistory] {
        let fetchRequest: NSFetchRequest<DriverIDHistory> = DriverIDHistory.fetchRequest()
        do {
            let history = try viewContext.fetch(fetchRequest)
            print("Fetched history: \(history)")
            return history
        } catch {
            print("Error fetching history: \(error.localizedDescription)")
            return []
        }
    }

    func createModel(aamvaData: AAMVAData) {
        let history = DriverIDHistory(context: viewContext)
        history.date = Date()
        history.lastName = aamvaData.lastName
        history.firstName = aamvaData.firstName
        history.jurisdiction = aamvaData.jurisdiction
        history.birthDate = aamvaData.birthDate
        history.expirationDate = aamvaData.expirationDate
        history.gender = aamvaData.gender
        do {
            try viewContext.save()
        } catch {
            print("Error saving history: \(error.localizedDescription)")
        }
    }
}
