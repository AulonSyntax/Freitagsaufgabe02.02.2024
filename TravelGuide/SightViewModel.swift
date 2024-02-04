//
//  SightViewModel.swift
//  TravelGuide
//
//  Created by Aulon Demolli on 04.02.24.
//

import Foundation
import SwiftUI

class SightViewModel: ObservableObject, Identifiable {
    
    @Published var title: String
    @Published var isVistied: Bool
    
    private let sight: Sight
    
    private let store = PersistentStore.shared

    init(sight: Sight) {
        self.sight = sight
        self.title = sight.title ?? "No title found"
        self.isVistied = sight.isVisited
    }
    
    func removeSight() {
        store.deleteSight(sight: self.sight)
    }
    
    func toggleVisited(isVisited: Bool) {
        store.toggleVisitedSight(sight: self.sight, isVisited: isVisited)
    }
}

