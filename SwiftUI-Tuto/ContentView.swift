//
//  ContentView.swift
//  SwiftUI-Tuto
//
//  Created by Lucas Goï on 08/10/2024.
//

import SwiftUI

class Inventory: ObservableObject {
    @Published var loot = [
        LootItem(name: "Frost Blade", type: .ice, rarity: .common, game: availableGames.randomElement()!),
        LootItem(name: "Fire Staff", type: .fire, rarity: .epic, game: availableGames.randomElement()!),
        LootItem(name: "Thunder Bow", type: .thunder, rarity: .rare, game: availableGames.randomElement()!),
        LootItem(name: "Poison Ring", type: .poison, rarity: .uncommon, game: availableGames.randomElement()!),
        LootItem(name: "Wind Shield", type: .wind, rarity: .legendary, game: availableGames.randomElement()!),
        LootItem(name: "Magic Amulet", type: .magic, rarity: .unique, game: availableGames.randomElement()!),
        LootItem(name: "Dagger of Shadows", type: .dagger, rarity: .rare, game: availableGames.randomElement()!),
        LootItem(name: "Bow of Eternity", type: .bow, rarity: .epic, game: availableGames.randomElement()!),
        LootItem(name: "Unknown Artifact", type: .unknown, rarity: .common, game: availableGames.randomElement()!)
    ]
    
    func addItem(name: String, type: ItemType, rarity: Rarity, game: Game) {
        loot.append(LootItem(name: name, type: type, rarity: rarity, game: game))
    }
}

struct ContentView: View {
    @StateObject var inventory = Inventory()
    @State private var selectedFeature: LooterFeature = .loot
    @State var showAddItemView = false

    var body: some View {
        TabView(selection: $selectedFeature) {

            NavigationStack {
                List(inventory.loot) { item in
                    NavigationLink {
                        LootDetailsView(item: item)
                    } label: {
                        VStack(alignment: .leading) {
                            HStack {
                                Circle()
                                    .fill(item.rarity.color)
                                    .frame(width: 12, height: 12)
                                Text(item.name)
                                    .font(.headline)
                                Spacer()
                                Text(item.type.icon)
                            }
                            Text("Quantité : \(item.quantity)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .sheet(isPresented: $showAddItemView, content: {
                    AddItemView().environmentObject(inventory)
                })
                .navigationBarTitle("Inventory")
                .toolbar(content: {
                    ToolbarItem(placement: .automatic) {
                        Button(action: {
                            showAddItemView.toggle()
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                        })
                    }
                })
            }
            .tabItem {
                Label("Loots", systemImage: "bag.fill")
            }
            .tag(LooterFeature.loot)
            
            WishListView()
                .tabItem {
                    Label("WishList", systemImage: "star.fill")
                }
                .tag(LooterFeature.wishList)

            ProfileView()
                .tabItem {
                    Label("Profil", systemImage: "person.fill")
                }
                .tag(LooterFeature.profile)
        }
    }
}

#Preview {
    ContentView()
}
