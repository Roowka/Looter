//
//  LootItem.swift
//  SwiftUI-Tuto
//
//  Created by Lucas Goï on 13/11/2024.
//

import Foundation
import SwiftUICore

struct LootItem: Identifiable {
    let id: UUID = UUID()
    var quantity: Int = 1 // Valeur par défaut
    var name: String
    var type: ItemType
    var rarity: Rarity
    var attackStrength: Int? // Optionnel
    var defenseStrength: Int?
    var hasCustomImage: Bool?
    var game: Game
}

enum ItemType: String, CaseIterable, Identifiable {
    case magic = "Magie"
    case fire = "Feu"
    case ice = "Glace"
    case wind = "Vent"
    case poison = "Poison"
    case thunder = "Foudre"
    case dagger = "Dague"
    case shield = "Bouclier"
    case bow = "Arc"
    case ring = "Anneau"
    case unknown = "Inconnu"

    var icon: String {
        return self.rawValue
    }

    var emoji: String {
        switch self {
        case .magic: return "⭐️"
        case .fire: return "🔥"
        case .ice: return "❄️"
        case .wind: return "💨"
        case .poison: return "☠️"
        case .thunder: return "⚡️"
        case .dagger: return "🗡️"
        case .shield: return "🛡️"
        case .bow: return "🏹"
        case .ring: return "💍"
        case .unknown: return "🎲"
        }
    }
    
    var id: String { rawValue }
}

enum Rarity: String, CaseIterable, Identifiable {
    case common = "Common"
    case uncommon = "Uncommon"
    case rare = "Rare"
    case epic = "Epic"
    case legendary = "Legendary"
    case unique = "Unique"
    
    var id: String { rawValue }
    
    var color: Color {
        switch self {
        case .common: return .gray
        case .uncommon: return .blue
        case .rare: return .orange
        case .epic: return .red
        case .legendary: return .purple
        case .unique: return .yellow
        }
    }
}
