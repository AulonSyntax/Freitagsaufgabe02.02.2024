//
//  FeedViewModel.swift
//  TravelGuide
//
//  Created by Aulon Demolli on 04.02.24.
//

import Foundation

class FeedViewModel: ObservableObject {
    
    @Published var destinations: [DestinationViewModel] = []
    
    private let store = PersistentStore.shared
    
    init() {
        destinations = store.fetchDestionations()
    }
    
    func reloadFeed() {
        destinations = store.fetchDestionations()
    }
    
    func createDestination(country: String, city: String, isVisited: Bool, sights: [(title: String, isVisited: Bool)]) {
        store.createDestination(country: country, city: city, isVisited: isVisited, sights: sights)
        reloadFeed()
    }
}
