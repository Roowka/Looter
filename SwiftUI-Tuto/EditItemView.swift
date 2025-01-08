//
//  EditItemView.swift
//  SwiftUI-Tuto
//
//  Created by Lucas Goï on 08/01/2025.
//

import SwiftUI

struct EditItemView: View {
    @State private var name: String
    @State private var rarity: Rarity
    @State private var game: Game
    @State private var quantity: Int
    @State private var type: ItemType
    @State private var attackStrength: Int?
    @State private var defenseStrength: Int?
    @State private var isAttackItem: Bool
    @State private var hasCustomImage: Bool
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var inventory: Inventory
    var item: LootItem

    // Initialiseur pour pré-remplir les valeurs de l'objet à modifier
    init(item: LootItem) {
        _name = State(initialValue: item.name)
        _rarity = State(initialValue: item.rarity)
        _game = State(initialValue: item.game)
        _quantity = State(initialValue: item.quantity)
        _type = State(initialValue: item.type)
        _attackStrength = State(initialValue: item.attackStrength)
        _defenseStrength = State(initialValue: item.defenseStrength)
        _isAttackItem = State(initialValue: item.attackStrength != nil)
        _hasCustomImage = State(initialValue: item.hasCustomImage ?? false)
        self.item = item
    }

    var body: some View {
        Form {
            Section(header: Text("Informations Générales")) {
                TextField("Nom de l'objet", text: $name)

                Picker("Rareté", selection: $rarity) {
                    ForEach(Rarity.allCases) { rarity in
                        Text(rarity.rawValue)
                            .foregroundColor(rarity.color)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                Stepper("Quantité : \(quantity)", value: $quantity, in: 1...99)
            }
            
            Section(header: Text("Jeu")) {
                Picker("Jeu", selection: $game) {
                    ForEach(availableGames, id: \.self) { game in
                        Text(game.name)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            
            Section(header: Text("Type")) {
                HStack {
                    Text("Type")
                    Spacer()
                    Text(type.emoji)
                }
                
                Picker("Type", selection: $type) {
                    ForEach(ItemType.allCases) { itemType in
                        Text(itemType.emoji).tag(itemType)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Image custom")) {
                Toggle("Image custom ?", isOn: $hasCustomImage)
                
                if hasCustomImage {
                    Button {
                        isImagePickerPresented = true
                    } label: {
                        Label("Choisir une image", systemImage: "photo")
                    }
                    .sheet(isPresented: $isImagePickerPresented) {
                        ImagePicker(selectedImage: $selectedImage)
                    }

                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .cornerRadius(12)
                    }
                }
            }

            Section(header: Text("Statistiques de Combat")) {
                Toggle("Item d'attaque ?", isOn: $isAttackItem)
                
                if isAttackItem {
                    Stepper("Force d'attaque : \(attackStrength ?? 0)", value: Binding(
                        get: { attackStrength ?? 0 },
                        set: { attackStrength = $0 }
                    ), in: 0...100)
                    
                    Stepper("Défense : \(defenseStrength ?? 0)", value: Binding(
                        get: { defenseStrength ?? 0 },
                        set: { defenseStrength = $0 }
                    ), in: 0...100)
                }
            }
            
            Button("Sauvegarder") {
                if let index = inventory.loot.firstIndex(where: { $0.id == item.id }) {
                    inventory.loot[index] = LootItem(
                        quantity: quantity,
                        name: name,
                        type: type,
                        rarity: rarity,
                        attackStrength: isAttackItem ? attackStrength : nil,
                        defenseStrength: isAttackItem ? defenseStrength : nil,
                        hasCustomImage: hasCustomImage,
                        game: game
                    )
                }
                dismiss()
            }
            
        }
        .navigationTitle("Modifier l'objet")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }
            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

#Preview {
    EditItemView(item: LootItem(
        quantity: 1,
        name: "Épée du Dragon",
        type: .dagger,
        rarity: .rare,
        attackStrength: 10,
        defenseStrength: 3,
        game: Game(name: "Elden Ring", genre: .rpg, coverName: "test")
    ))
    .environmentObject(Inventory())
}
