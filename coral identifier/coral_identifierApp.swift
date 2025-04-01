//
//  coral_indetifierApp.swift
//  coral indetifier
//
//  Created by PinHsuan Tsai on 2024/8/28.
//

import SwiftUI

@main
struct coral_identifierApp: App {
    init() {
        setupAPIKey()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Article.self, Video.self, Coral.self])
    }
    private func setupAPIKey() {
            do {
                // Check if we already have a key stored
                if ((try? APIKeyManager.shared.getAPIKey()) == nil) {
                    // Only save if we don't already have one
                    try APIKeyManager.shared.saveAPIKey("aa3779c0773d7488d052f14e75bb9adf")
                    print("API key saved successfully")
                }
            } catch {
                print("Failed to setup API key: \(error)")
            }
        }
}
