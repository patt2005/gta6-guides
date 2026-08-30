import Foundation

enum CheatCategory: String, CaseIterable, Codable {
    case player = "Player"
    case combat = "Combat"
    case world = "World"
    case vehicles = "Vehicles"
}

struct CheatCode: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let category: CheatCategory
    let ps5Input: String
    let xboxInput: String
    let pcInput: String
    
    init(id: UUID = UUID(), title: String, description: String, category: CheatCategory, ps5Input: String, xboxInput: String, pcInput: String) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.ps5Input = ps5Input
        self.xboxInput = xboxInput
        self.pcInput = pcInput
    }
}
