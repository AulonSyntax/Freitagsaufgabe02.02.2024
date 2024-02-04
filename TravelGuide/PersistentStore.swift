//
//  PersistentStore.swift
//  TravelGuide
//
//  Created by Aulon Demolli on 04.02.24.
//

import CoreData

class PersistentStore {
    
    static let shared = PersistentStore()
    
    private let container: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        self.container.viewContext
    }
    
    private init() {
        self.container = NSPersistentContainer(name: "TravelGuide")
        
        self.container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to acces Core Data database: \(error)")
            }
        }
    }
    
    private func save() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            NSLog("Failed to save Core Data database: \(error)")
        }
    }
    
    func fetchDestionations() -> [DestinationViewModel] {
        let fetchRequest = Destination.fetchRequest()
        
        
        do {
            return try context.fetch(fetchRequest).map {
                DestinationViewModel(destination: $0)
            }
        } catch {
            NSLog("Failed to fetch from Core Data database: \(error)")
        }
        
        return []
    }
    
    func createDestination(country: String, city: String, isVisited: Bool, sights: [(title: String, isVisited: Bool)]) {
        let destination = Destination(context: context)
        destination.id = UUID()
        destination.country = country
        destination.city = city
        for sight in sights {
            let newSight = Sight(context: context)
            newSight.id = UUID()
            newSight.title = sight.title
            newSight.isVisited = sight.isVisited
            newSight.destination = destination
            destination.sights?.adding(newSight)
        }
        
        save()
    }
    
    func createSight(destination: Destination, title: String, isVisited: Bool) {
        let sight = Sight(context: context)
        sight.title = title
        sight.isVisited = isVisited
        sight.destination = destination
        destination.sights?.adding(sight)
        
        save()
    }
    
    func deleteDestination(destination: Destination) {
        context.delete(destination)
        save()
    }
    
    func deleteSight(sight: Sight) {
        context.delete(sight)
        save()
    }
    
    func toggleVisitedDestination(destination: Destination, isVisited: Bool) {
        destination.isVisited = isVisited
        save()
    }
    
    func toggleVisitedSight(sight: Sight, isVisited: Bool) {
        sight.isVisited.toggle()
        save()
    }
}

