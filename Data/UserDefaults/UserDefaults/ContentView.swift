//
//  ContentView.swift
//  UserDefaults
//
//  Created by Куприянов Тимофей on 24.03.2026.
//

import SwiftUI

// @AppStorage - UserDefaults, в идеале держать <~100 кб.
// В нем хранят какие-то постоянные данные (ну да, ну да, defaults), такие как тема, пройден ли онбординг, мелкие настройки типа уведомлений и тому подобного или, к примеру, перешел ли юзер по ссылкам на соцсети приложения/разраба
// В целом ограничения по размеру нет, но от размера userdefaults напрямую зависит то, насколько быстро приложение будет запускаться, а это важно.


struct ContentView: View {
    @AppStorage("tap") private var tapCount = 0
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
    }
}

#Preview {
    ContentView()
}
