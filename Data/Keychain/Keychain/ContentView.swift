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

// with package
final class KeychainWithPackage {
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


// without package
class KeychainManager {
    enum KeychainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
    }
    
    static func save(
        service: String,
        account: String,
        password: Data
    ) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: password as AnyObject
        ]
        
        let status = SecItemAdd(
            query as CFDictionary,
            nil
        )
        
        if status == errSecDuplicateItem {
            throw KeychainError.duplicateEntry
        } else if status != errSecSuccess {
            throw KeychainError.unknown(status)
        }
        
        print("saved")
    }
    
    static func get(
        service: String,
        account: String,
    ) -> Data? {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &result
        )
        
        print("read status: \(status)")
        
        return result as? Data
    }
}

#Preview {
    ContentView()
}
