//
//  MovieListScreen.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 14.6.24..
//

import SwiftUI
import SwiftData

//umesto ovog sranja sa modelContex-om i task-om koristimo Query !!!

struct MovieListScreen: View {
//    @State var list: [Movie] = []
    @State private var isAddMoviePresented: Bool = false
    // gave me all
    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
//    @Environment(\.modelContext) private var context
    var body: some View {
//        VStack{
            List(movies) { movie in
                Text(movie.title)
            }
//        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Movie"){
                    isAddMoviePresented = true
                }
            }
        }
        .sheet(isPresented: $isAddMoviePresented, content: {
            // bez navigaion stack-a ne mozemo da vidimo toolbar ekrana
            NavigationStack{
                AddMovieScreen()
            }
        })
//        .task {
//            
//            do {
//                let fetchDescriptor = FetchDescriptor<Movie>()
//                
//                self.list = try self.context.fetch(fetchDescriptor)
//            }catch{
//                print(error.localizedDescription)
//            }
//        }
    }
}

#Preview {
    MovieListScreen()
        .modelContainer(for: [Movie.self])
}
