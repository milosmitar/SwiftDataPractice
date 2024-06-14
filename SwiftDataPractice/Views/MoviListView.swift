//
//  MoviListView.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 14.6.24..
//

import SwiftUI
import SwiftData

struct MoviListView: View {
    
    let movies: [Movie]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        List{
            ForEach(movies){ movie in
                NavigationLink(value: movie) {
                    HStack{
                        Text(movie.title)
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
    MoviListView(movies: [])
        .modelContainer(for: [Movie.self])
}
