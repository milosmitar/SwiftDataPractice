//
//  MovieDetailScreen.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 14.6.24..
//

import SwiftUI
import SwiftData

struct MovieDetailScreen: View {
    @Environment(\.modelContext) private var context
    let movie: Movie
    @State private var title: String = ""
    @State private var year: Int?
    @State private var showReviewScreen: Bool = false
    var body: some View {
        Form{
            TextField("Title", text: $title)
            TextField("Year", value: $year, format: .number)
            Button("Update"){
                guard let year = year else { return }
                
                movie.title = title
                movie.year = year
                
                do{
                    try context.save()
                }catch{
                    print(error.localizedDescription)
                }
            }.buttonStyle(.borderless)
            
            Section("Reviews"){
                Button(action: {
                    showReviewScreen = true
                }, label: {
                    Image(systemName: "plus")
                        .frame(maxWidth:.infinity, alignment: .trailing)
                })
                
                if movie.reviews.isEmpty{
                    ContentUnavailableView{
                        Text("No reviews")
                    }
                }else{
                    ReviewListView(movie: movie)
                }
                
            }
        }
        .onAppear(){
            title = movie.title
            year = movie.year
        }
        .sheet(isPresented: $showReviewScreen, content: {
            NavigationStack{
                AddReviewScreen(movie: movie)
            }
        })
    }
}

// Sve je ovo samo za preview
struct MovieDetailConainerScreen: View {
    
    @Environment(\.modelContext) private var context
    @State private var movie: Movie?
    var body: some View {
        
        ZStack{
            if let movie {
                MovieDetailScreen(movie: movie)
            }
        }
        
        Text("Container screen")
            .onAppear{
                movie = Movie(title: "sp", year: 2013)
                context.insert(movie!)
            }
    }
}
#Preview {
    MovieDetailConainerScreen()
        .modelContainer(for: [Movie.self])
}
