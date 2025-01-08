import SwiftUI

struct LootDetailsView: View {
    let item: LootItem
    @State private var isAppeared: Bool = false
    @State private var circleScale: CGFloat = 0.5
    @State private var circleOpacity: Double = 0.0
    @State private var isEditSheetPresented: Bool = false

    var body: some View {
        VStack {

            // Bouton Edit en haut à droite
            HStack {
                Spacer()
                Button{
                    isEditSheetPresented.toggle()
                } label: {
                    Label("Editer", systemImage: "pencil")
                }
                .padding()
            }

            ZStack {
                // Cercles en dessous
                ForEach(0..<5) { index in
                    Circle()
                        .fill(item.rarity.color.opacity(0.2 - (Double(index) * 0.05)))
                        .frame(width: 120, height: 120)
                        .opacity(isAppeared ? 1 : 0)
                        .scaleEffect(isAppeared ? 1.2 + (CGFloat(index) * 0.2) : 1)
                        .animation(.easeOut(duration: 1).delay(0.7), value: isAppeared)
                }
                
                // Rectangle principal + emoji
                ZStack {
                    Rectangle()
                        .fill(LinearGradient(
                            colors: [item.rarity.color.opacity(1), item.rarity.color],
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(width: 120, height: 120)
                        .cornerRadius(30)

                    Text(item.type.emoji)
                        .font(.system(size: 60))
                }
                .rotation3DEffect(
                    .degrees(isAppeared ? 360 : 0),
                    axis: (x: 1, y: 1, z: 0)
                )
            }
            .onAppear {
                withAnimation(.spring(response: 0.6).delay(0.4)) {
                    isAppeared = true
                }
                withAnimation(.easeOut(duration: 2)) {
                    circleScale = 2.5
                    circleOpacity = 0.0
                }
            }

            Spacer(minLength: 30)

            // Nom de l'item
            Text(item.name)
                .font(.title)
                .bold()
                .foregroundColor(item.rarity.color)

            Spacer(minLength: 120)

            // Badge pour les items uniques
            if item.rarity == .unique {
                HStack {
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
                .scaleEffect(isAppeared ? 1 : 0)
                .animation(.easeOut(duration: 1), value: isAppeared)
            }

            Spacer(minLength: 25)

            // Formulaire avec les informations
            Form {
                Section(header: Text("INFORMATIONS")) {
                    HStack {
                        Image(item.game.coverName ?? "")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 58, height: 58)
                            .cornerRadius(4)
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
        .sheet(isPresented: $isEditSheetPresented) {
            EditItemView(item: item)
        }
    }
}

// Prévisualisation pour tester dans Xcode
struct LootDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleItem = LootItem(
            quantity: 2,
            name: "Épée du Désespoir",
            type: .dagger,
            rarity: .unique,
            attackStrength: 4,
            game: Game(name: "Elden Ring", genre: .rpg, coverName: "eldenring")
        )
        LootDetailsView(item: sampleItem)
    }
}
