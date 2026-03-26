//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Куприянов Тимофей on 26.03.2026.
//


import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = [Destination]()
    @State private var sortOrder = SortDescriptor(\Destination.name)
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder, searchString: searchText)
                .navigationTitle("Destinations")
                .navigationDestination(for: Destination.self) { destination in
                    EditDestinationView(destination: destination)
                }
                .searchable(text: $searchText)
                .toolbar {
                    Button("Add Destination", systemImage: "plus", action: addDestination)
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\Destination.name))
                            
                            Text("Priority")
                                .tag(SortDescriptor(\Destination.priority, order: .reverse))
                            
                            Text("Date")
                                .tag(SortDescriptor(\Destination.date))
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
    
    
}

#Preview {
    ContentView()
}

