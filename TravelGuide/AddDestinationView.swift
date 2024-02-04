//
//  AddDestinationView.swift
//  TravelGuide
//
//  Created by Aulon Demolli on 04.02.24.
//

import SwiftUI

struct AddDestinationView: View {
    
    @State private var country: String = ""
    @State private var city: String = ""
    @State private var isVisited: Bool = false
    @State private var sights: [(title: String, isVisited: Bool)] = []
    
    var viewModel: FeedViewModel
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        Form {
            Section("Destination") {
                TextField("Country", text: $country)
                TextField("City", text: $city)
                Toggle("Visted", isOn: $isVisited)
            }
            ForEach($sights, id: \.self.title) { $sight in
                Section("Sight") {
                    TextField("Title", text: $sight.title)
                    Toggle("Visited", isOn: $sight.isVisited)
                }
            }
            Button("Add sight", action: {
                sights.append((title: "", isVisited: false))
            })
            .frame(maxWidth: .infinity)
            if !sights.isEmpty {
                Button("Remove last sight", action: {
                    sights.removeLast()
                })
                .frame(maxWidth: .infinity)
            }
            Button("Save destination", action: {
                addDestination()
            })
            .frame(maxWidth: .infinity)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Form not filled"),
                message: Text("I think you forgot something")
            )
        }
    }
    
    private func addDestination() {
        guard !country.isEmpty, !city.isEmpty, !sights.isEmpty else {
            showAlert.toggle()
            return
        }
        for sight in sights {
            guard !sight.title.isEmpty else {
                showAlert.toggle()
                return
            }
        }
        
        viewModel.createDestination(country: country, city: city, isVisited: isVisited, sights: sights)
        
        country = ""
        city = ""
        isVisited = false
        sights = []
    }
}

#Preview {
    AddDestinationView(viewModel: FeedViewModel())
}
