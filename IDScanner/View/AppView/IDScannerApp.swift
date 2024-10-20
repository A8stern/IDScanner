//
//  IDScannerApp.swift
//  IDScanner
//
//  Created by Kovalev Gleb on 18.09.2024.
//

import SwiftUI

@main
struct IDScannerApp: App {
    let coreDataManager = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataManager.persistentContainer.viewContext)
                .preferredColorScheme(.light)
        }
    }
}
