import Foundation

enum GuideCategory: String, CaseIterable, Codable {
    case general = "General"
    case missions = "Missions"
    case collectibles = "Collectibles"
    case vehicles = "Vehicles"
    case weapons = "Weapons"
    case activities = "Activities"
}

struct Guide: Identifiable, Codable {
    let id: UUID
    let title: String
    let category: GuideCategory
    let summary: String
    let content: String
    let readingTime: Int // in minutes
    var isBookmarked: Bool
    var isCompleted: Bool
    
    init(id: UUID = UUID(), title: String, category: GuideCategory, summary: String, content: String, readingTime: Int, isBookmarked: Bool = false, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.category = category
        self.summary = summary
        self.content = content
        self.readingTime = readingTime
        self.isBookmarked = isBookmarked
        self.isCompleted = isCompleted
    }
}
