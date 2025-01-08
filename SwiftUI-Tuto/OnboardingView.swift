//
//  OnboardingView.swift
//  SwiftUI-Tuto
//
//  Created by Lucas Goï on 08/01/2025.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboardingDone: Bool
    @State private var currentPage = 0

    var body: some View {
        TabView(selection: $currentPage) {
            OnboardingPageView(
                imageName: "backpack.circle.fill",
                title: "Gérer ses loots",
                description: "Ajoutez facilement vos trouvailles et vos achats à votre collection personnelle.",
                imageColor: Color.blue,
                currentPage: $currentPage,
                isLastPage: false,
                isOnboardingDone: $isOnboardingDone
            )
            .tag(0)
            
            OnboardingPageView(
                imageName: "wand.and.rays",
                title: "Votre wishlist",
                description: "Créez une liste de souhaits pour garder une trace des articles que vous voulez acquérir.",
                imageColor: Color.yellow,
                currentPage: $currentPage,
                isLastPage: false,
                isOnboardingDone: $isOnboardingDone
            )
            .tag(1)
            
            OnboardingPageView(
                imageName: "iphone",
                title: "En un coup d'œil",
                description: "Accédez rapidement à vos fonctionnalités clés depuis l’écran d’accueil de votre appareil.",
                imageColor: Color.purple,
                currentPage: $currentPage,
                isLastPage: true,
                isOnboardingDone: $isOnboardingDone
            )
            .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always)) 
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView(isOnboardingDone: .constant(false))
}
