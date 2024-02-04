//
//  DestinationView.swift
//  TravelGuide
//
//  Created by Aulon Demolli on 04.02.24.
//

import SwiftUI

struct DestinationView: View {
    
    @StateObject var destinationViewModel: DestinationViewModel
    
    @State private var addSight: Bool = false
    @State private var sightTitle: String = ""
    @State private var sightVisited: Bool = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
   var body: some View {
        List {
            Section("Destination") {
                Text(destinationViewModel.country)
                Text(destinationViewModel.city)
                Toggle("Visited", isOn: $destinationViewModel.isVisited)
            }
            
            ForEach(destinationViewModel.sights, id: \.self.title) { sight in
                Section("Sight") {
                    HStack {
                        Text(sight.title)
                        Spacer()
                        Button(action: {
                            destinationViewModel.moveSightToDelete(sight: sight)
                        }, label: {
                            Image(systemName: "trash")
                                .tint(.red)
                        })
                    }
                    Toggle("Visited", isOn: getSightBinging(sight: sight))
                }
            }
            
            TextField("New Sight", text: $sightTitle)
            Toggle("Visted", isOn: $sightVisited)
            
            Button("Save changes") {
                for sight in destinationViewModel.sights {
                    sight.toggleVisited(isVisited: sight.isVistied)
                }
                destinationViewModel.toggleVisited(isVisited: destinationViewModel.isVisited)
                if !sightTitle.isEmpty {
                    destinationViewModel.addSight(title: sightTitle, isVisited: sightVisited)
                }
                destinationViewModel.deleteSights()
                
                self.presentationMode.wrappedValue.dismiss()
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private func getSightBinging(sight: SightViewModel) -> Binding<Bool> {
        return Binding<Bool>(
            get: {
                sight.isVistied
            },
            set: { newValue in
                sight.isVistied = newValue
            }
        )
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
    
    return DestinationView(destinationViewModel: DestinationViewModel(destination: destination))
}
