//
//  WishListView.swift
//  SwiftUI-Tuto
//
//  Created by Lucas Goï on 08/01/2025.
//

import SwiftUI

struct WishListView: View {
    var body: some View {
        VStack {
            Text("WishList")
                .font(.largeTitle)
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
        }
    }
}
