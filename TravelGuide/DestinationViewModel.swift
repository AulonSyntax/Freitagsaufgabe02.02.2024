//
//  DestinationViewModel.swift
//  TravelGuide
//
//  Created by Aulon Demolli on 04.02.24.
//

import Foundation

class DestinationViewModel: ObservableObject, Identifiable {
    
    @Published var country: String = ""
    @Published var city: String = ""
    @Published var sights: [SightViewModel] = []
    @Published var isVisited: Bool = false
    
    @Published var sightsToDelete: [SightViewModel] = []
    
    private let destination: Destination
    
    private let store = PersistentStore.shared
    
    init(destination: Destination) {
        self.destination = destination
        self.country = destination.country ?? "No country found"
        self.city = destination.city ?? "No city found"
        self.isVisited = destination.isVisited
        
        if let sightList = destination.sights {
            for sight in sightList {
                self.sights.append(SightViewModel(sight: sight as! Sight))
            }
        }
    }
    
    func addSight(title: String, isVisited: Bool) {
        store.createSight(destination: self.destination, title: title, isVisited: isVisited)
    }
    
    func removeDestination() {
        store.deleteDestination(destination: self.destination)
    }
    
    func toggleVisited(isVisited: Bool) {
        store.toggleVisitedDestination(destination: self.destination, isVisited: isVisited)
    }
    
    func moveSightToDelete(sight: SightViewModel) {
        sightsToDelete.append(sight)
        if let index = sights.firstIndex(where: { $0.id == sight.id }) {
            sights.remove(at: index)
        }
    }
    
    func deleteSights() {
        for sight in sightsToDelete {
            sight.removeSight()
        }
        sightsToDelete.removeAll()
    }
}

