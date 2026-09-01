import Foundation

enum CheatCategory: String, CaseIterable, Codable, Identifiable {
    case all = "All"
    case player = "Player & Health"
    case combat = "Weapons & Combat"
    case vehicles = "Vehicles & Spawns"
    case world = "World & Weather"
    case gameplay = "Special & Gameplay"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .all: return "square.grid.2x2.fill"
        case .player: return "heart.fill"
        case .combat: return "flame.fill"
        case .vehicles: return "car.2.fill"
        case .world: return "cloud.sun.rain.fill"
        case .gameplay: return "wand.and.stars"
        }
    }
}

enum GamingPlatform: String, CaseIterable, Codable, Identifiable {
    case ps5 = "PlayStation 5"
    case xbox = "Xbox Series X|S"
    case pc = "PC"
    case phone = "In-Game Phone"
    
    var id: String { rawValue }
    
    var shortName: String {
        switch self {
        case .ps5: return "PS5"
        case .xbox: return "Xbox"
        case .pc: return "PC"
        case .phone: return "Phone"
        }
    }
    
    var iconName: String {
        switch self {
        case .ps5: return "playstation.logo"
        case .xbox: return "xbox.logo"
        case .pc: return "desktopcomputer"
        case .phone: return "phone.fill"
        }
    }
}

struct CheatCode: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let category: CheatCategory
    let imageUrl: String
    let ps5Buttons: [String]
    let xboxButtons: [String]
    let pcInput: String
    let phoneInput: String
    let effects: [String]
    let warning: String?
    let tips: String
    var isFavorite: Bool
    
    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        category: CheatCategory,
        imageUrl: String = "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800",
        ps5Buttons: [String],
        xboxButtons: [String],
        pcInput: String,
        phoneInput: String = "1-999-GTA-CODE",
        effects: [String] = [],
        warning: String? = "Using cheat codes disables Trophies and Achievements for the current save session.",
        tips: String = "Enter the button combination quickly during normal gameplay (not in pause menu).",
        isFavorite: Bool = false
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.imageUrl = imageUrl
        self.ps5Buttons = ps5Buttons
        self.xboxButtons = xboxButtons
        self.pcInput = pcInput
        self.phoneInput = phoneInput
        self.effects = effects
        self.warning = warning
        self.tips = tips
        self.isFavorite = isFavorite
    }
    
    // Convenience getters for raw string representations
    var ps5Input: String {
        ps5Buttons.joined(separator: " ")
    }
    
    var xboxInput: String {
        xboxButtons.joined(separator: " ")
    }
}
