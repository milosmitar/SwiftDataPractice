//
//  FilterSelectionScreen.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 5.7.24..
//

import SwiftUI

enum FilterOption{
    case title(String)
    case reviewsCount(Int)
    case none
}

struct FilterSelectionScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var movieTitle: String = ""
    
    @Binding var filterOption: FilterOption
    @State var numberOfReviews: Int?
    
    var body: some View {
        Form{
            Section("Filter by title"){
                TextField("Movie title",text: $movieTitle)
                Button("Search"){
                    filterOption = .title(movieTitle)
                    dismiss()
                }
            }
            Section("Filter by number of reviews"){
                TextField("Number of reviews",value: $numberOfReviews, format: .number)
                    .keyboardType(.numberPad)
                Button("Search"){
                    filterOption = .reviewsCount(numberOfReviews ?? 1)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    FilterSelectionScreen(filterOption: .constant(.title("Lego")))
}
