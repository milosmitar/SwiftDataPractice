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
    case genre(Genre)
    case none
}

struct FilterSelectionScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var filterSelection: FilterSelection
    
    var body: some View {
        Form{
            Section("Filter by title"){
                TextField("Movie title",text: $filterSelection.movieTitle)
                Button("Search"){
                    filterSelection.filterOption = .title(filterSelection.movieTitle)
                    
                    dismiss()
                }
            }
            Section("Filter by number of reviews"){
                TextField("Number of reviews",value: $filterSelection.numberOfReviews, format: .number)
                    .keyboardType(.numberPad)
                Button("Search"){
                    filterSelection.filterOption = .reviewsCount(filterSelection.numberOfReviews ?? 1)
                    dismiss()
                }
            }
            Section("Filter by genre"){
                Picker("Genre", selection: $filterSelection.genre) {
                    ForEach(Genre.allCases){ genre in
                        
                        Text(genre.title).tag(genre)
                        
                    }
                }
            }
            .onChange(of: filterSelection.genre) {
                filterSelection.filterOption = .genre(filterSelection.genre)
            }
        }
    }
}

#Preview {
    FilterSelectionScreen(filterSelection: .constant(FilterSelection()))
}
struct FilterSelection {
    
    var movieTitle: String = ""
    var numberOfReviews: Int = 0
    var genre: Genre = .action
    var filterOption: FilterOption = .none
}
