//
//  Actor.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 18.6.24..
//

import Foundation
import SwiftData

@Model
final class Actor {
    var name: String
    
    var movies: [Movie] = []
    
    init(name: String) {
        self.name = name
    }
}
