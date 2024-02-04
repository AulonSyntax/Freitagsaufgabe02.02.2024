//
//  FeedView.swift
//  TravelGuide
//
//  Created by Aulon Demolli on 04.02.24.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var feedViewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(feedViewModel.destinations) { destination in
                    NavigationLink(destination: DestinationView(destinationViewModel: destination), label: {
                        FeedRow(destination: destination)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    destination.removeDestination()
                                    feedViewModel.reloadFeed()
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .swipeActions(edge: .leading) {
                                Button(role: .none) {
                                    destination.toggleVisited(isVisited: !destination.isVisited)
                                    feedViewModel.reloadFeed()
                                } label: {
                                    Label("Done", systemImage: "heart.fill")
                                }
                                .tint(.green)
                            }
                    })
                }
            }
            .onAppear {
                feedViewModel.reloadFeed()
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink("Add destination", destination: {
                    AddDestinationView(viewModel: feedViewModel)
                })
            }
        }
    }
}

#Preview {
    return FeedView()
}
