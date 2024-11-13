//
//  Game.swift
//  SwiftUI-Tuto
//
//  Created by Lucas Goï on 13/11/2024.
//

import Foundation

enum GameGenre {
    case mmorpg, rpg, looter, fps, tps, strategy, unset
}

struct Game: Identifiable, Hashable {
    let name: String
    let id: UUID = UUID()
    let genre: GameGenre
    let coverName : String?
    
    static var emptyGame = Game(name: "", genre: .unset, coverName: nil)
}

// Hesitez pas mettre vos propres jeux dans la liste
let availableGames = [
    Game(name: "Elden Ring", genre: .rpg, coverName: "eldenring"),
    Game(name: "Skyrim", genre: .rpg, coverName: "skyrim"),
    Game(name: "WoW", genre: .mmorpg, coverName: "wow"),
    Game(name: "CS:GO", genre: .fps, coverName: "cs2"),
    Game(name: "Diablo IV", genre: .looter, coverName: "diablo")
]
