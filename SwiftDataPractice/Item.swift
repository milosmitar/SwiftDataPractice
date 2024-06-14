//
//  Item.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 14.6.24..
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
