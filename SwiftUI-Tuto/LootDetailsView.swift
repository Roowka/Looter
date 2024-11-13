//
//  LootDetailView.swift
//  SwiftUI-Tuto
//
//  Created by Lucas Goï on 13/11/2024.
//

import SwiftUI


struct LootDetailsView: View {
    let item: LootItem

    var body: some View {
            VStack {
                Spacer(minLength: 50)
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            colors: [item.rarity.color.opacity(0.5), item.rarity.color],
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(width: 120, height: 120)
                    Text(item.type.emoji)
                        .font(.system(size: 60))
                }
                
                Spacer(minLength: 30)
                
                Text(item.name)
                    .font(.title)
                    .bold()
                    .foregroundColor(item.rarity.color)
                
                Spacer(minLength: 120)
                
                if(item.rarity == .unique){
                    HStack{
                        Text("Item Unique 🏆")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                        .padding(.horizontal, 120)
                                .padding(.vertical, 20)
                                .background(LinearGradient(
                                    colors: [item.rarity.color.opacity(0.5), item.rarity.color],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ))
                                .cornerRadius(20)
                }
                
                Spacer(minLength: 25)

                Form{
                    Section(
                        header: Text("INFORMATIONS")
                    ){
                        Section {
                            HStack{
                                Image(item.game.coverName ?? "")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 58, height: 58)
                                Text(item.game.name)
                            }
                            Text("In-game : " + item.name)
                            if let attackStrength = item.attackStrength {
                                Text("Puissance (ATQ) : \(attackStrength)")
                            }
                            Text("Possédé(s) : " + String(item.quantity))
                            Text("Rareté : " + item.rarity.rawValue)
                        }
                    }
                }
            }
            
    }
}

struct LootDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleItem = LootItem(
            quantity: 2,
            name: "Epée du Désespoir",
            type: .dagger,
            rarity: .unique,
            attackStrength: 4,
            game: Game(name: "Elden Ring", genre: .rpg, coverName: "eldenring")
        )
        LootDetailsView(item: sampleItem)
    }
}
