//
//  ContentView.swift
//  Continuation
//
//  Created by Куприянов Тимофей on 18.02.2026.
//

import SwiftUI
import Combine


class ContinuationNetworkService {
    func getData(url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            return data
        } catch {
            throw error
        }
    }
    
    
    func getData2(url: URL) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    continuation.resume(returning: data)
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: URLError(.badServerResponse))
                }
            }
            .resume()
        }
    }
    
    
    func getHeartImageFromDatabase(completionHandler: @escaping (_ image: UIImage) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            completionHandler(UIImage(systemName: "heart.fill")!)
        }
    }
    
    func getHeartImageFromDatabase() async -> UIImage {
        await withCheckedContinuation { continuation in
            getHeartImageFromDatabase { image in
                continuation.resume(returning: image)
            }
        }
    }
}



class ContinuationViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let networkService = ContinuationNetworkService()
    
    func getImage() async {
        guard let url = URL(string: "https://picsum.photos/200") else { return }
        
        do {
            let data = try await networkService.getData2(url: url)
            
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.image = image
                }
            }
        } catch {
            print(error)
        }
    }
    
    
    func getHeartImage() {
        networkService.getHeartImageFromDatabase { [weak self] image in
            self?.image = image
        }
    }
    
    func getHeartImageFromDatabase2() async {
        let image = await networkService.getHeartImageFromDatabase()
        self.image = image
    }
}

struct ContentView: View {
    @StateObject private var viewModel = ContinuationViewModel()
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            //await viewModel.getImage()
            await viewModel.getHeartImage()
            
        }
    }
}

#Preview {
    ContentView()
}
