//
//  ContentView.swift
//  Searchable
//
//  Created by Куприянов Тимофей on 21.02.2026.
//

import SwiftUI
import Combine

struct Restaurant: Identifiable, Hashable {
    let id: String
    let title: String
    let cuisine: CuisineOption
}


enum CuisineOption: String {
    case american
    case italian
    case japanese
}


final class RestaurantManager {
    
    
    func getAllRestaurants() async throws -> [Restaurant] {
        [
            Restaurant(id: "1", title: "MacDonalds", cuisine: .american),
            Restaurant(id: "2", title: "Pasta Place", cuisine: .italian),
            Restaurant(id: "3", title: "Sushi World", cuisine: .japanese),
            Restaurant(id: "4", title: "Local Market", cuisine: .american),
        ]
    }
}


@MainActor
final class SearchableViewModel: ObservableObject {
    @Published private(set) var allRestaurants: [Restaurant] = []
    @Published private(set) var filteredRestaurants: [Restaurant] = []
    @Published var searchText: String = ""

    
    let manager = RestaurantManager()
    
    var isSearching: Bool {
        !searchText.isEmpty
    }
    
    
    func loadRestaurants() async {
        do {
            allRestaurants = try await manager.getAllRestaurants()
        } catch {
            print(error)
        }
    }
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.filteredRestaurants(searchText: searchText)
            }
    }
    
    private func filteredRestaurants(searchText: String) {
        guard searchText.isEmpty else {
            filteredRestaurants = []
            return
        }
        let search = searchText.lowercased()
        
        filteredRestaurants = allRestaurants.filter({ restaurant in
            let titleContainsSearch = restaurant.title.contains(search)
            let cuisineContainsSearch = restaurant.cuisine.rawValue.contains(search)
            return titleContainsSearch || cuisineContainsSearch
        })
    }
}

struct ContentView: View {
    @StateObject private var viewModel = SearchableViewModel()
    var body: some View {
        
        ScrollView {
            VStack(spacing:20) {
                ForEach(viewModel.isSearching ? viewModel.filteredRestaurants : viewModel.allRestaurants) { restaurant in
                    restaurantRow(restaurant: restaurant)
                }
            }
            .padding()
            
            Text("ViewModel is searching: \(viewModel.isSearching.description)")
            SearchChildView()
        }
        .searchable(text: $viewModel.searchText, placement: .automatic, prompt: Text("Search"))
        //.navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Restaurants")
        .task {
            await viewModel.loadRestaurants()
        }
    }
    
    private func restaurantRow(restaurant: Restaurant) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(restaurant.title)
                .font(.headline)
            Text(restaurant.cuisine.rawValue.capitalized)
                .font(.caption)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.black.opacity(0.05))
    }
}

struct SearchChildView: View {
    @Environment(\.isSearching) private var isSearching
    var body: some View {
        Text("Child view is searching: \(isSearching.description)")
    }
}


struct Searchable_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
        }
    }
}

#Preview {
    ContentView()
}
