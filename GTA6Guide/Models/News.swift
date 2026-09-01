import Foundation

struct NewsItem: Identifiable, Codable {
    let id: UUID
    let title: String
    let category: String
    let date: Date
    let summary: String
    let content: String
    let imageUrl: String
    let source: String
    let readTimeMinutes: Int
    var isBookmarked: Bool

    init(
        id: UUID = UUID(),
        title: String,
        category: String = "Official Update",
        date: Date = Date(),
        summary: String,
        content: String = "",
        imageUrl: String = "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800",
        source: String = "Rockstar Games NewsWire",
        readTimeMinutes: Int = 3,
        isBookmarked: Bool = false
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.date = date
        self.summary = summary
        self.content = content
        self.imageUrl = imageUrl
        self.source = source
        self.readTimeMinutes = readTimeMinutes
        self.isBookmarked = isBookmarked
    }
}
