//
//  ContentView.swift
//  SlidersInSwiftUI
//
//  Created by Куприянов Тимофей on 04.12.2025.
//

import SwiftUI
import AVFoundation
import Combine

class PlayerViewModel : ObservableObject {
    @Published public var maxDuration = 0.0
    private var player : AVAudioPlayer?
    
    public func play() {
        playSong(name: "song")
        player?.play()
    }
    
    public func stop() {
        player?.stop()
    }
    
    public func setTime(value: Float) {
        guard let time = TimeInterval(exactly: value) else { return }
        player?.currentTime = time
        player?.play()
    }
    
    private func playSong(name: String) {
        guard let audioPath = Bundle.main.path(forResource: name, ofType: "m4a") else {
            return
        }
        do {
            try player = AVAudioPlayer(contentsOf: URL(filePath: audioPath))
            maxDuration = player?.duration ?? 0.0
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ContentView: View {
    @State private var progress: Float = 0
    @ObservedObject var viewModel = PlayerViewModel()
    
    var body: some View {
        VStack {
            Slider(value: Binding(get:
                                    { Double(self.progress) },
                                  set:
                                    { newValue in
                self.progress = Float(newValue)
                self.viewModel.setTime(value: Float(newValue))
            }),
                   in: 0...viewModel.maxDuration)
                .padding()
                .tint(.orange)
            HStack {
                Button("Play", action: { self.viewModel.play() })
                    .tint(.white)
                    .frame(width: 100, height: 50)
                    .background(Color.accentColor)
                    .clipShape(Capsule())
                Button("Stop", action: { self.viewModel.stop() })
                    .tint(.white)
                    .frame(width: 100, height: 50)
                    .background(Color.red)
                    .clipShape(Capsule())
            }
        }
    }
}

#Preview {
    ContentView()
}
