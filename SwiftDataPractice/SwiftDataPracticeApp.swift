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
            container = try ModelContainer(for: Movie.self, migrationPlan: MoviesMigrationPlan.self, configurations: ModelConfiguration(for: Movie.self))
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
