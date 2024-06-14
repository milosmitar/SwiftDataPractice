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
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                MovieListScreen()
            }
        }.modelContainer(for: [Movie.self])
    }
}
