import Foundation

struct Character: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    let abilities: [String]
    let stats: [String: Double] // e.g., "Stamina": 0.8
    let imageName: String
    
    init(id: UUID = UUID(), name: String, description: String, abilities: [String], stats: [String : Double], imageName: String) {
        self.id = id
        self.name = name
        self.description = description
        self.abilities = abilities
        self.stats = stats
        self.imageName = imageName
    }
}
