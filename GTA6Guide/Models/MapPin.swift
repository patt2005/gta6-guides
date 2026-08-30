import Foundation
import CoreGraphics

enum PinType: String, CaseIterable, Codable {
    case safehouse = "Safehouse"
    case weapon = "Weapon"
    case collectible = "Collectible"
    case activity = "Activity"
    case secret = "Secret"
}

struct MapPin: Identifiable, Codable {
    let id: UUID
    let title: String
    let type: PinType
    let coordinate: CGPoint // Relative coordinates (0.0 to 1.0)
    var isCompleted: Bool
    
    init(id: UUID = UUID(), title: String, type: PinType, coordinate: CGPoint, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.type = type
        self.coordinate = coordinate
        self.isCompleted = isCompleted
    }
}
