import Foundation
import CoreGraphics

enum PinType: String, CaseIterable, Codable, Identifiable {
    case all = "All"
    case safehouse = "Safehouse"
    case weapon = "Ammu-Nation"
    case collectible = "Collectible"
    case activity = "Activity & Club"
    case garage = "Mod Shop / Pay'n'Spray"
    case stunt = "Stunt Jump"
    case secret = "Secret Easter Egg"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .all: return "square.grid.2x2.fill"
        case .safehouse: return "house.fill"
        case .weapon: return "scope"
        case .collectible: return "star.fill"
        case .activity: return "flame.fill"
        case .garage: return "wrench.and.screwdriver.fill"
        case .stunt: return "bolt.car.fill"
        case .secret: return "questionmark.diamond.fill"
        }
    }
    
    var colorHex: String {
        switch self {
        case .all: return "FFFFFF"
        case .safehouse: return "00F0FF" // Cyan
        case .weapon: return "FF2E63" // Neon Pink
        case .collectible: return "FFBE0B" // Gold
        case .activity: return "FF6B6B" // Sunset Orange
        case .garage: return "00E676" // Neon Green
        case .stunt: return "9B51E0" // Purple
        case .secret: return "E040FB" // Magenta
        }
    }
}

struct MapPin: Identifiable, Codable {
    let id: UUID
    let title: String
    let subtitle: String
    let type: PinType
    let coordinate: CGPoint // Relative coordinates (0.0 to 1.0)
    let description: String
    let reward: String?
    var isCompleted: Bool
    
    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String = "Leonida State",
        type: PinType,
        coordinate: CGPoint,
        description: String = "Explore this point of interest in Vice City.",
        reward: String? = nil,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.type = type
        self.coordinate = coordinate
        self.description = description
        self.reward = reward
        self.isCompleted = isCompleted
    }
}
