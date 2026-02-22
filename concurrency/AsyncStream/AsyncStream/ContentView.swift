//
//  ContentView.swift
//  AsyncStream
//
//  Created by Куприянов Тимофей on 22.02.2026.
//

import SwiftUI
import Combine

class AsyncStreamDataManager {
    
    func getAsyncStream() -> AsyncThrowingStream<Int, Error> {
        AsyncThrowingStream(Int.self) { [weak self] continuation in
            self?.getFakeData { value in
                continuation.yield(value)
            } onFinish: { error in
                if let error {
                    continuation.finish(throwing: error)
                } else {
                    continuation.finish()
                }
            }

        }
    }
    
    func getFakeData(
        newValue: @escaping (_ value: Int) -> Void,
        onFinish: @escaping (_ error: Error?) -> Void
    ) {
        let items: [Int] = [1,2,3,4,5,6,7,8,9,10]
        
        for item in items {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(item), execute: {
                newValue(item)
                
                if item == items.last {
                    onFinish(nil)
                }
            })
        }
    }
}


@MainActor
final class AsyncStreamViewModel: ObservableObject {
    
    let manager = AsyncStreamDataManager()
    @Published private(set) var currentNumber: Int = 0
    
    func onViewAppear() {
//        manager.getFakeData { [weak self] value in
//            self?.currentNumber = value
//        }
        let task = Task {
            do {
                for try await value in manager.getAsyncStream() {
                    currentNumber = value
                }
            } catch {
                print(error)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            task.cancel()
            print("Task cancelled")
        })
    }
}


struct ContentView: View {
    @StateObject private var viewModel = AsyncStreamViewModel()
    var body: some View {
        Text("\(viewModel.currentNumber)")
            .onAppear {
                viewModel.onViewAppear()
            }
    }
}

#Preview {
    ContentView()
}

