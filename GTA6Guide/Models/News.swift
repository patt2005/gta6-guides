import Foundation

struct NewsItem: Identifiable, Codable {
    let id: UUID
    let title: String
    let date: Date
    let summary: String
    let content: String // Add this
    let url: String?

    init(id: UUID = UUID(), title: String, date: Date = Date(), summary: String, content: String = "", url: String? = nil) {
        self.id = id
        self.title = title
        self.date = date
        self.summary = summary
        self.content = content
        self.url = url
    }
}
