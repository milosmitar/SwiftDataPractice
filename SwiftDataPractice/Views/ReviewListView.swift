//
//  ReviewListView.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 17.6.24..
//

import SwiftUI

struct ReviewListView: View {
    @Environment(\.modelContext) private var context
//    let reviews: [Review]
    let movie: Movie
    
    
    var body: some View {
        List{
            ForEach(movie.reviews){ review in
                
                VStack(alignment: .leading){
                    Text(review.subject)
                    Text(review.body)
                }
                
            }.onDelete(perform: deleteReview)
        }
        
    }
    func deleteReview(indexSet: IndexSet){
        indexSet.forEach { index in
            let review = movie.reviews[index]
            context.delete(review)
            
            do{
                movie.reviews.remove(at: index)
                try context.save()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

//#Preview {
//    ReviewListView(reviews: [])
//        .modelContainer(for: [Review.self, Movie.self])
//}
