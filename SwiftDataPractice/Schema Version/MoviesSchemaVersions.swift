//
//  MoviesSchemaVersions.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 8.7.24..
//

import Foundation
import SwiftData

enum MoviesSchemaV1: VersionedSchema {
    
    
    static var versionIdentifier: Schema.Version = .init(1,0,0)
    
    static var models: [any PersistentModel.Type] {
        [Movie.self]
    }
    
    @Model
    final class Movie {
    //    @Attribute(.unique)
    // ---- Migration
        // Slucaj da baza ne menja ime samo se u kodu menja
    //    @Attribute( originalName: "title")
    //    var name : String
        
//        @Attribute(.unique)
        var title: String
        
        var year: Int
        
        
        // Not stored to database
        @Transient var reviewsCount: Int{
            reviews.count
        }
        
        @Transient var actorsCount: Int{
            actors.count
        }
        
        @Relationship(deleteRule: .cascade, inverse: \Review.movie)
        var reviews: [Review] = []
        
        @Relationship(deleteRule: .noAction, inverse: \Actor.movies)
        var actors: [Actor] = []
        
        init(title: String, year: Int) {
            self.title = title
            self.year = year
        }
    }
    
}
enum MoviesSchemaV2: VersionedSchema {
    
    // Adding unique constraint to movie name.
    static var versionIdentifier: Schema.Version = .init(2,0,0)
    
    static var models: [any PersistentModel.Type] {
        [Movie.self]
    }
    
    @Model
    final class Movie {
    //    @Attribute(.unique)
    // ---- Migration
        // Slucaj da baza ne menja ime samo se u kodu menja
    //    @Attribute( originalName: "title")
    //    var name : String
        
        @Attribute(.unique)
        var title: String
        
        var year: Int
        
        
        // Not stored to database
        @Transient var reviewsCount: Int{
            reviews.count
        }
        
        @Transient var actorsCount: Int{
            actors.count
        }
        
        @Relationship(deleteRule: .cascade, inverse: \Review.movie)
        var reviews: [Review] = []
        
        @Relationship(deleteRule: .noAction, inverse: \Actor.movies)
        var actors: [Actor] = []
        
        init(title: String, year: Int) {
            self.title = title
            self.year = year
        }
    }
    
}

enum MoviesSchemaV3: VersionedSchema {
    
    // Adding unique constraint to movie name.
    static var versionIdentifier: Schema.Version = .init(3,0,0)
    
    static var models: [any PersistentModel.Type] {
        [Movie.self]
    }
    
    @Model
    final class Movie {
    //    @Attribute(.unique)
    // ---- Migration
        // Slucaj da baza ne menja ime samo se u kodu menja
    //    @Attribute( originalName: "title")
    //    var name : String
        
        @Attribute(.unique, originalName: "title")
        var name: String
        
        var year: Int
        
        
        // Not stored to database
        @Transient var reviewsCount: Int{
            reviews.count
        }
        
        @Transient var actorsCount: Int{
            actors.count
        }
        
        @Relationship(deleteRule: .cascade, inverse: \Review.movie)
        var reviews: [Review] = []
        
        @Relationship(deleteRule: .noAction, inverse: \Actor.movies)
        var actors: [Actor] = []
        
        init(name: String, year: Int) {
            self.name = name
            self.year = year
        }
    }
    
}
