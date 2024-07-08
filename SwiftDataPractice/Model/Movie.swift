//
//  Movie.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 14.6.24..
//

import Foundation
import SwiftData

@Model
final class Movie {
//    @Attribute(.unique)
    var title : String
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
