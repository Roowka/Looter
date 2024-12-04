//
//  AddItemView.swift
//  SwiftUI-Tuto
//
//  Created by Lucas Goï on 08/10/2024.
//

import SwiftUI

struct AddItemView: View {
    @State private var name: String = ""
    @State private var rarity: Rarity = .common
    @State private var game: Game = Game.emptyGame
    @State private var quantity = 0
    @State private var type : ItemType = .unknown
    @State private var attackStrength = 0
    @State private var isAttackItem :Bool = false
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var inventory: Inventory
    
    func incrementQuantity() {
            quantity += 1
        }
    
    func decrementQuantity() {
        if(quantity > 0){
            quantity -= 1
            }
        }
    
    func incrementAttackStrength() {
        attackStrength += 1
        }
    
    func decrementAttackStrength() {
        if(attackStrength > 0){
            attackStrength -= 1
            }
        }
    
    var body: some View {
        Form {
            Section {
                TextField("Nom de l'objet", text: $name)
                
                Picker("Rareté", selection: $rarity) {
                    ForEach(Rarity.allCases, id: \.self) { rarity in
                        Text(rarity.rawValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            Section{
                Picker("Jeu", selection: $game) {
                    ForEach(availableGames, id: \.self) { game in
                        Text(game.name)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                Stepper {
                    Text("Quantité :  \(quantity)")
                        } onIncrement: {
                            incrementQuantity()
                        } onDecrement: {
                            decrementQuantity()
                        }
            }
            Section{
                HStack{
                    Text("Type")
                    Spacer()
                    Text(type.emoji)
                }
                
                Picker("type", selection: $type){
                    ForEach(ItemType.allCases){ itemType in
                        Text(itemType.emoji).tag(itemType)
                    }
                }.pickerStyle(PalettePickerStyle())
            }
            
            Section{
                Toggle("Item d'attaque ?", isOn: $isAttackItem)
                
                if(isAttackItem){
                    Stepper {
                        Text("Force d'attaque :  \(attackStrength)")
                            } onIncrement: {
                                incrementAttackStrength()
                            } onDecrement: {
                                decrementAttackStrength()
                            }
                }
            }
            
            Button("Ajouter"){
                inventory.addItem(name: name, type: type,rarity: rarity, game: game)
                dismiss()
            }
        }
    }
}


#Preview {
    AddItemView()
}
