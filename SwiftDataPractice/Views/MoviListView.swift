//
//  MoviListView.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 14.6.24..
//

import SwiftUI
import SwiftData

struct MoviListView: View {
    
    @Query private let movies: [Movie]
    
    let filterOption: FilterOption
    
    init(filterOption: FilterOption = .none){
        self.filterOption = filterOption
        
        switch filterOption {
        case .title(let movieTitle):
            _movies = Query(filter: #Predicate<Movie> { movie in
                movie.title.contains(movieTitle)
            })
        case .none:
            _movies = Query()
        }
    }
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        List{
            ForEach(movies){ movie in
                NavigationLink(value: movie) {
                    HStack(alignment: .firstTextBaseline){
                        VStack(alignment: .leading){
                            Text(movie.title)
                            Text("Number of reviews: \(movie.reviewsCount)")
                                .font(.caption)
                            Text("Number of actors: \(movie.actorsCount)")
                                .font(.caption)
                        }
                        Spacer()
                        Text(movie.year.description)
                    }
                }
            }.onDelete(perform: deleteMovie)
        }.navigationDestination(for: Movie.self) { movie in
            MovieDetailScreen(movie: movie)
        }
    }
    private func deleteMovie(indexSet: IndexSet){
        indexSet.forEach { index in
            let movie = movies[index]
            context.delete(movie)
            
            do{
                try context.save()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    MoviListView(filterOption: .none)
        .modelContainer(for: [Movie.self])
}
