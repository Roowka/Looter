//
//  ProfileView.swift
//  SwiftUI-Tuto
//
//  Created by Lucas Goï on 08/01/2025.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Profil")
                .font(.largeTitle)
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
        }
    }
}
