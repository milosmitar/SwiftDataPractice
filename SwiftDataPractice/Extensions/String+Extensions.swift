//
//  String+Extensions.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 14.6.24..
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
