//
//  ReviewListView.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 17.6.24..
//

import SwiftUI

struct ReviewListView: View {
    
    let reviews: [Review]
    
    var body: some View {
        List{
            ForEach(reviews){ review in
                
                VStack(alignment: .leading){
                    Text(review.subject)
                    Text(review.body)
                }
                
            }
        }
        
    }
}

#Preview {
    ReviewListView(reviews: [])
}
