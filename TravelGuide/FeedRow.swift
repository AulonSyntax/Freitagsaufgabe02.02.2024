//
//  FeedRow.swift
//  TravelGuide
//
//  Created by Aulon Demolli on 04.02.24.
//

import SwiftUI

struct FeedRow: View {
    
    var destination: DestinationViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Country: \(destination.country)")
                Text("City: \(destination.city)")
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 8) {
                Image(systemName: destination.isVisited ? "heart.fill" : "heart")
                Text("Sights: \(destination.sights.count)")
            }
        }
    }
}

#Preview {
    let destination = Destination(context: PersistentStore.shared.context)
    destination.id = UUID()
    destination.country = "Germany"
    destination.city = "Mannheim"
    destination.isVisited = true
    let sightOne = Sight(context: PersistentStore.shared.context)
    sightOne.id = UUID()
    sightOne.title = "Sight One"
    sightOne.isVisited = true
    sightOne.destination = destination
    let sightTwo = Sight(context: PersistentStore.shared.context)
    sightTwo.id = UUID()
    sightTwo.title = "Sight Two"
    sightTwo.isVisited = false
    sightTwo.destination = destination
    destination.addToSights(sightOne)
    destination.addToSights(sightTwo)
    
    return FeedRow(destination: DestinationViewModel(destination: destination))
}

