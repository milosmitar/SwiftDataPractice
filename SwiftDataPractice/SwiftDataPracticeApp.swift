//
//  SwiftDataPracticeApp.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 14.6.24..
//

import SwiftUI
import SwiftData

@main
struct SwiftDataPracticeApp: App {
    
    let container: ModelContainer
    
    init(){
        do{
            
            let databasePath = URL.documentsDirectory.appending(path: "database.store")
            // use database at:
            // sqlite3 database.store
// /Users/itsuser/Library/Developer/CoreSimulator/Devices/203E8187-354F-4492-AEAD-B5B2EB9E6092/data/Containers/Data/Application/7C9030FE-6B8E-4635-BEE4-9A86A50FEDE5/Documents/database.store
            let configuration = ModelConfiguration(url: databasePath)

//            let container = try ModelContainer.init(
//               for: Item.self, Foo.self, Bar.self,
//               migrationPlan: Plan.self,
//               configurations: configuration
//            )
//            
            container = try ModelContainer(for: Movie.self, migrationPlan: MoviesMigrationPlan.self, configurations: configuration)
        }catch{
            fatalError("Could not initialize the container.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                MovieListScreen()
            }
        }
        .modelContainer(container)
//        .modelContainer(for: [Movie.self])
    }
}
