//
//  ActorDetailScreen.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 4.7.24..
//

import SwiftUI

struct ActorDetailScreen: View {
    
    let actor: Actor
    @State var selectedMovie: Set<Movie>  = []
    @Environment(\.modelContext) private var context
    var body: some View {
        VStack{
            MovieSelectionView(selectedMovies: $selectedMovie)
                .onAppear{
                    selectedMovie = Set(actor.movies )
                }
        }
        .onChange(of: selectedMovie, {
            actor.movies = Array(selectedMovie)
            context.insert(actor)
        })
        .navigationTitle(actor.name)
    }
}

