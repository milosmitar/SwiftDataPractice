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
    @State private var movieTitle: String = ""
    
    @Binding var filterOption: FilterOption
    @State var numberOfReviews: Int?
    @State private var genre: Genre = .action
    
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
            Section("Filter by genre"){
                Picker("Genre", selection: $genre) {
                    ForEach(Genre.allCases){ genre in
                        
                        Text(genre.title).tag(genre)
                        
                    }
                }
            }
            .onChange(of: genre) {
                filterOption = .genre(genre)
            }
        }
    }
}

#Preview {
    FilterSelectionScreen(filterOption: .constant(.title("Lego")))
}
