//
//  MoviesMigrationPlan.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 8.7.24..
//

import Foundation
import SwiftData

enum MoviesMigrationPlan: SchemaMigrationPlan {
    
    static var schemas: [any VersionedSchema.Type]{
        [MoviesSchemaV1.self, MoviesSchemaV2.self]
    }
    
    static var stages: [MigrationStage]{
        [migrateV1toV2]
    }
    
    static let migrateV1toV2 = MigrationStage.custom(fromVersion: MoviesSchemaV1.self, toVersion: MoviesSchemaV2.self, willMigrate: { context in
        
        guard let movies = try? context.fetch(FetchDescriptor<Movie>()) else { return }
            
        var duplicates = Set<Movie>()
        var uniqueSet = Set<String>()
        
        for movie in movies {
            if !uniqueSet.insert(movie.title).inserted{
                duplicates.insert(movie)
            }
        }
        
        for movie in duplicates {
            
            guard let movieToBeUpdated =  movies.first(where: { $0.id == movie.id }) else { continue }
            movieToBeUpdated.title = movieToBeUpdated.title + "(Duplicate) \(UUID().uuidString)"
            
        }
        
        try? context.save()
        
    }, didMigrate: nil)
    
}
