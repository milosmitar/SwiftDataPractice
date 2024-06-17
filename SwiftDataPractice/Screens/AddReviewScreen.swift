//
//  AddReviewScreen.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 17.6.24..
//

import SwiftUI
import SwiftData

struct AddReviewScreen: View {
    
    let movie: Movie
    @State private var subject: String = ""
    @State private var description: String = ""
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    private var isFormValid: Bool{
        !subject.isEmptyOrWhiteSpace && !description.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        
        Form {
            TextField("Subject", text: $subject)
            TextField("Description", text: $description)
            
        }.navigationTitle("Add Review")
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save"){
                        
                        let review = Review(subject: subject, body: description)
                        review.movie = movie
                        context.insert(review)
                        
                        do{
                            try context.save()
                            movie.reviews?.append(review)
                        }catch{
                            print(error.localizedDescription)
                        }
                        
                        dismiss()
                        
                    }.disabled(!isFormValid)
                }
            }
        
    }
    func saveReview(){
        
    }
    
}

//#Preview {
//    AddReviewScreen()
//}
