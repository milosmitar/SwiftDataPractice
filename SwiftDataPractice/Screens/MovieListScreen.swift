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

struct MovieListScreen: View {
//    @State var list: [Movie] = []
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var isAddMoviePresented: Bool = false
    @State private var isActorPresented: Bool = false
    @State private var actorName: String = ""
    // gave me all
    @Query(sort: \Movie.title, order: .forward)
    private var movies: [Movie]
    
    @Query(sort: \Actor.name, order: .forward)
    private var actors: [Actor]
    //    @Environment(\.modelContext) private var context
    var body: some View {
        VStack(alignment: .leading){
            Text("Movies")
                .font(.largeTitle)
            MoviListView(movies: movies)
            
            Text("Actors")
                .font(.largeTitle)
            ActorListView(actors: actors)
        }
        .padding()
        .toolbar{
            ToolbarItem( placement: .topBarLeading) {
                Button("Add Actor"){
                    isActorPresented = true
                }
            }
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
        .sheet(isPresented: $isActorPresented, content: {
            //            NavigationStack{
            Text("Add Actor")
            TextField("Actor name", text: $actorName)
                .textFieldStyle(.roundedBorder)
                .presentationDetents([.fraction(0.25)])
                .padding()
            Button("Save"){
                isActorPresented = true
                saveActor()
                
            }
            //            }
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
    private func saveActor(){
        let actor = Actor(name: actorName)
        context.insert(actor)
        isActorPresented = false
    }
}

#Preview {
    NavigationStack{
        MovieListScreen()
            .modelContainer(for: [Movie.self, Review.self, Actor.self])
    }
}
