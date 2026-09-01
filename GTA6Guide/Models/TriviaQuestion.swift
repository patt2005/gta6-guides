import Foundation

struct TriviaQuestion: Identifiable, Codable {
    let id: UUID
    let question: String
    let options: [String]
    let correctOptionIndex: Int
    let explanation: String
    let category: String
    
    init(
        id: UUID = UUID(),
        question: String,
        options: [String],
        correctOptionIndex: Int,
        explanation: String,
        category: String = "Vice City Lore"
    ) {
        self.id = id
        self.question = question
        self.options = options
        self.correctOptionIndex = correctOptionIndex
        self.explanation = explanation
        self.category = category
    }
}
