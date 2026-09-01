import Foundation

enum WeaponCategory: String, CaseIterable, Codable, Identifiable {
    case all = "All"
    case handguns = "Handguns"
    case smgs = "SMGs & PDWs"
    case shotguns = "Shotguns"
    case assaultRifles = "Assault Rifles"
    case snipers = "Sniper Rifles"
    case heavy = "Heavy Weapons"
    case melee = "Melee & Throwables"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .all: return "square.grid.2x2.fill"
        case .handguns: return "cross.circle"
        case .smgs: return "bolt.fill"
        case .shotguns: return "shield.righthalf.filled"
        case .assaultRifles: return "scope"
        case .snipers: return "target"
        case .heavy: return "flame.fill"
        case .melee: return "scalemass.fill"
        }
    }
}

struct Weapon: Identifiable, Codable {
    let id: UUID
    let name: String
    let category: WeaponCategory
    let damage: Double // 0.0 to 1.0
    let fireRate: Double // 0.0 to 1.0
    let accuracy: Double // 0.0 to 1.0
    let range: Double // 0.0 to 1.0
    let magazineCapacity: Int
    let price: Int
    let attachments: [String]
    let description: String
    let unlockRequirement: String
    let imageUrl: String
    var isFavorite: Bool
    
    init(
        id: UUID = UUID(),
        name: String,
        category: WeaponCategory,
        damage: Double,
        fireRate: Double,
        accuracy: Double,
        range: Double,
        magazineCapacity: Int,
        price: Int,
        attachments: [String] = [],
        description: String,
        unlockRequirement: String = "Available at Ammu-Nation",
        imageUrl: String,
        isFavorite: Bool = false
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.damage = damage
        self.fireRate = fireRate
        self.accuracy = accuracy
        self.range = range
        self.magazineCapacity = magazineCapacity
        self.price = price
        self.attachments = attachments
        self.description = description
        self.unlockRequirement = unlockRequirement
        self.imageUrl = imageUrl
        self.isFavorite = isFavorite
    }
}
