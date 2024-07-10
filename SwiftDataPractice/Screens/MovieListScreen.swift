//
//  MovieListScreen.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 14.6.24..
//

import SwiftUI
import SwiftData
/// Na edit sheme u argument-u upisujemo -com.apple.CoreData.SQLDebug 1 da bi videli query-je u log-u
//umesto ovog sranja sa modelContex-om i task-om koristimo Query !!!

enum Sheets: Identifiable {
    
    case addMovie
    case addActor
    case showFilter
    
    var id: Int{
        hashValue
    }
    
}

struct MovieListScreen: View {
//    @State var list: [Movie] = []
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var actorName: String = ""
    
    @State private var activeSheet: Sheets?
    
    // gave me all
    @Query(sort: \Movie.name, order: .forward)
//    @Query(filter: #Predicate<Movie> { movie in
//        
////        movie.title.contains("Spider")
////        ...
//        movie.year > 2013 && movie.actors.count > 0
//        
//    })
    private var movies: [Movie]
    
    @Query(sort: \Actor.name, order: .forward)
    private var actors: [Actor]
    //    @Environment(\.modelContext) private var context
    @State var filterSelection: FilterSelection = FilterSelection()
    
    
    private func saveActor(){
        let actor = Actor(name: actorName)
        context.insert(actor)
        self.activeSheet = nil
    }
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                Text("Movies")
                    .font(.largeTitle)
                Spacer()
                Button("Filter"){
                    activeSheet = .showFilter
                }
            }
            
            Button("Clear Filters"){
                filterSelection = FilterSelection()
            }
            
            MoviListView(filterOption: filterSelection.filterOption)
            
            Text("Actors")
                .font(.largeTitle)
            ActorListView(actors: actors)
        }
        .padding()
        .toolbar{
            ToolbarItem( placement: .topBarLeading) {
                Button("Add Actor"){
                    activeSheet = .addActor
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Movie"){
                    
                    activeSheet = .addMovie
                }
            }
        }
        .sheet(item: $activeSheet){ activeSheet in
            
            switch activeSheet {
            case .addMovie:
                NavigationStack{
                    AddMovieScreen()
                }
            case .addActor:
                Text("Add Actor")
                TextField("Actor name", text: $actorName)
                    .textFieldStyle(.roundedBorder)
                    .presentationDetents([.fraction(0.25)])
                    .padding()
                Button("Save"){
                    saveActor()
                    
                }
            case .showFilter:
                FilterSelectionScreen(filterSelection: $filterSelection)
            }
        }
    }

}

#Preview {
    NavigationStack{
        MovieListScreen()
            .modelContainer(for: [Movie.self, Review.self, Actor.self], inMemory: true)
    }
}
