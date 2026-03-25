//
//  ContentView.swift
//  Keychain
//
//  Created by Куприянов Тимофей on 25.03.2026.
//

import SwiftUI
import KeychainSwift

// keyhcain похож на userdefaults (appstorage), но только хранит данные в secure storage
// точно также, для данных небольшого размера, но, в отличии от appstorage, тут хранят private data, по типу токенов и тп
// keychain синхронизируется во всех устройствах в рамках одного icloud аккаунта

// здесь используется keychain-swift

final class KeychainManager {
    let keychain: KeychainSwift
    
    init() {
        let keychain = KeychainSwift()
        keychain.synchronizable = true
        self.keychain = keychain
    }
}


struct ContentView: View {
    let keychain = KeychainSwift()
    @State private var userAuthKey: String = ""
    var body: some View {
        Button(userAuthKey.isEmpty ? "No AuthKey" : userAuthKey) {
            let newAuthKey = "efgh"
            keychain.synchronizable = true // синхронизация
            keychain.set("abcd", forKey: "user_authkey") // withAccess: .accessibleWhenUnlocked
            userAuthKey = newAuthKey
            
            //keychain.delete("my key")
            //keychain.clear()
        }
        .onAppear {
            userAuthKey = keychain.get("user_authkey") ?? ""
        }
    }
}

#Preview {
    ContentView()
}
