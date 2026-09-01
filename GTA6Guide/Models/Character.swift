import Foundation

struct Character: Identifiable, Codable {
    let id: UUID
    let name: String
    let role: String
    let faction: String
    let description: String
    let backstory: String
    let abilities: [String]
    let preferredWeapons: [String]
    let signatureVehicle: String
    let stats: [String: Double] // e.g., "Stamina": 0.85
    let imageName: String
    let imageUrl: String
    
    init(
        id: UUID = UUID(),
        name: String,
        role: String = "Protagonist",
        faction: String = "Independent",
        description: String,
        backstory: String = "",
        abilities: [String],
        preferredWeapons: [String] = [],
        signatureVehicle: String = "",
        stats: [String: Double],
        imageName: String,
        imageUrl: String = "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=800"
    ) {
        self.id = id
        self.name = name
        self.role = role
        self.faction = faction
        self.description = description
        self.backstory = backstory
        self.abilities = abilities
        self.preferredWeapons = preferredWeapons
        self.signatureVehicle = signatureVehicle
        self.stats = stats
        self.imageName = imageName
        self.imageUrl = imageUrl
    }
}
