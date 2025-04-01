//
//  APIKeyManager.swift
//  coral identifier
//
//  Created by PinHsuan Tsai on 2024/10/28.
//

import Foundation

enum APIKeyError: Error {
    case keyNotFound
    case saveFailed
    case loadFailed
}

class APIKeyManager {
    static let shared = APIKeyManager()
    
    private let keychain = KeychainWrapper.standard
    private let apiKeyKey = "weatherAPIKey"
    
    private init() {}
    
    func saveAPIKey(_ apiKey: String) throws {
        let saved = keychain.set(apiKey, forKey: apiKeyKey)
        if !saved {
            throw APIKeyError.saveFailed
        }
    }
    
    func getAPIKey() throws -> String {
        guard let apiKey = keychain.string(forKey: apiKeyKey) else {
            throw APIKeyError.keyNotFound
        }
        return apiKey
    }
    
    func deleteAPIKey() {
        keychain.removeObject(forKey: apiKeyKey)
    }
}

// MARK: - KeychainWrapper
class KeychainWrapper {
    static let standard = KeychainWrapper()
    
    private init() {}
    
    func string(forKey key: String) -> String? {
        guard let data = getData(forKey: key) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func set(_ value: String, forKey key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        return set(data, forKey: key)
    }
    
    func removeObject(forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
    
    private func getData(forKey key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        return (status == errSecSuccess) ? (result as? Data) : nil
    }
    
    private func set(_ data: Data, forKey key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
}
