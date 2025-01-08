//
//  LooterApp.swift
//  SwiftUI-Tuto
//
//  Created by Lucas Goï on 08/01/2025.
//

import SwiftUI

@main
struct LooterApp: App {
    @AppStorage("isOnboardingDone") private var isOnboardingDone: Bool = false

    var body: some Scene {
        WindowGroup {
            // Pour les tests faut mettre la ligne en dessous
            // let _ = { isOnboardingDone = false }()
            
            if isOnboardingDone {
                ContentView()
            } else {
                OnboardingView(isOnboardingDone: $isOnboardingDone)
            }
        }
    }
}
