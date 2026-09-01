import Foundation

enum GuideCategory: String, CaseIterable, Codable, Identifiable {
    case all = "All"
    case missions = "Missions & Heists"
    case money = "Money & Business"
    case collectibles = "Collectibles"
    case vehicles = "Vehicles & Tuning"
    case weapons = "Weapons & Combat"
    case secrets = "Secrets & Easter Eggs"
    case activities = "Activities & Mini-Games"
    case general = "General & Tips"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .all: return "square.grid.2x2.fill"
        case .missions: return "flag.checkered"
        case .money: return "dollarsign.circle.fill"
        case .collectibles: return "star.fill"
        case .vehicles: return "car.fill"
        case .weapons: return "scope"
        case .secrets: return "sparkles"
        case .activities: return "gamecontroller.fill"
        case .general: return "lightbulb.fill"
        }
    }
}

enum GuideDifficulty: String, CaseIterable, Codable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    case master = "Master"
    
    var colorHex: String {
        switch self {
        case .beginner: return "00F0FF" // Cyan
        case .intermediate: return "FFBE0B" // Gold
        case .advanced: return "FF6B6B" // Sunset Orange
        case .master: return "FF2E63" // Neon Pink
        }
    }
}

struct GuideStep: Identifiable, Codable {
    let id: UUID
    let stepNumber: Int
    let title: String
    let instruction: String
    let tip: String?
    var isCompleted: Bool
    
    init(id: UUID = UUID(), stepNumber: Int, title: String, instruction: String, tip: String? = nil, isCompleted: Bool = false) {
        self.id = id
        self.stepNumber = stepNumber
        self.title = title
        self.instruction = instruction
        self.tip = tip
        self.isCompleted = isCompleted
    }
}

struct Guide: Identifiable, Codable {
    let id: UUID
    let title: String
    let category: GuideCategory
    let difficulty: GuideDifficulty
    let summary: String
    let content: String
    let imageUrl: String
    let readingTime: Int // in minutes
    let rewards: [String]
    let requirements: [String]
    var steps: [GuideStep]
    let tags: [String]
    var userNotes: String
    var isBookmarked: Bool
    var isCompleted: Bool
    
    init(
        id: UUID = UUID(),
        title: String,
        category: GuideCategory,
        difficulty: GuideDifficulty = .beginner,
        summary: String,
        content: String,
        imageUrl: String = "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800",
        readingTime: Int,
        rewards: [String] = [],
        requirements: [String] = [],
        steps: [GuideStep] = [],
        tags: [String] = [],
        userNotes: String = "",
        isBookmarked: Bool = false,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.difficulty = difficulty
        self.summary = summary
        self.content = content
        self.imageUrl = imageUrl
        self.readingTime = readingTime
        self.rewards = rewards
        self.requirements = requirements
        self.steps = steps
        self.tags = tags
        self.userNotes = userNotes
        self.isBookmarked = isBookmarked
        self.isCompleted = isCompleted
    }
    
    var completedStepsCount: Int {
        steps.filter { $0.isCompleted }.count
    }
    
    var stepsProgress: Double {
        guard !steps.isEmpty else { return isCompleted ? 1.0 : 0.0 }
        return Double(completedStepsCount) / Double(steps.count)
    }
}
