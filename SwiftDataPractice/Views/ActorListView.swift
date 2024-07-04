//
//  ActorListView.swift
//  SwiftDataPractice
//
//  Created by Milos Mitrovic on 18.6.24..
//

import SwiftUI

struct ActorListView: View {
    
    let actors: [Actor]
    
    var body: some View {
        List(actors) { actor in
            Text(actor.name)
            
        }
    }
}

#Preview {
    ActorListView(actors: [])
}
