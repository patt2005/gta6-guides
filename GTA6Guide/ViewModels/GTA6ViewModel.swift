import Foundation
import Combine
import SwiftUI

final class GTA6ViewModel: ObservableObject {
    @Published var guides: [Guide] = []
    @Published var mapPins: [MapPin] = []
    @Published var cheatCodes: [CheatCode] = [] // Add this
    @Published var characters: [Character] = []
    @Published var newsItems: [NewsItem] = []
    
    @Published var searchText: String = ""
    @Published var selectedCategory: GuideCategory? = nil
    
    private let dataService = DataService.shared
    
    init() {
        loadData()
    }
    
    func loadData() {
        self.guides = dataService.fetchGuides()
        self.mapPins = dataService.fetchMapPins()
        self.cheatCodes = dataService.fetchCheatCodes() // Add this
        self.characters = dataService.fetchCharacters()
        self.newsItems = dataService.fetchNews()
    }
    
    // MARK: - Filtered Data
    
    var filteredGuides: [Guide] {
        guides.filter { guide in
            let matchesSearch = searchText.isEmpty || guide.title.localizedCaseInsensitiveContains(searchText) || guide.summary.localizedCaseInsensitiveContains(searchText)
            let matchesCategory = selectedCategory == nil || guide.category == selectedCategory
            return matchesSearch && matchesCategory
        }
    }
    
    var bookmarkedGuides: [Guide] {
        guides.filter { $0.isBookmarked }
    }
    
    // MARK: - Actions
    
    func toggleBookmark(for guide: Guide) {
        if let index = guides.firstIndex(where: { $0.id == guide.id }) {
            guides[index].isBookmarked.toggle()
            dataService.saveGuides(guides)
        }
    }
    
    func toggleCompletion(for guide: Guide) {
        if let index = guides.firstIndex(where: { $0.id == guide.id }) {
            guides[index].isCompleted.toggle()
            dataService.saveGuides(guides)
        }
    }
    
    func togglePinCompletion(for pin: MapPin) {
        if let index = mapPins.firstIndex(where: { $0.id == pin.id }) {
            mapPins[index].isCompleted.toggle()
            dataService.saveMapPins(mapPins)
        }
    }
    
    // MARK: - Progress Stats
    
    var overallProgress: Double {
        let totalItems = Double(guides.count + mapPins.count)
        guard totalItems > 0 else { return 0 }
        
        let completedItems = Double(guides.filter { $0.isCompleted }.count + mapPins.filter { $0.isCompleted }.count)
        return completedItems / totalItems
    }
    
    func progress(for category: GuideCategory) -> Double {
        let categoryGuides = guides.filter { $0.category == category }
        guard !categoryGuides.isEmpty else { return 0 }
        
        let completed = categoryGuides.filter { $0.isCompleted }.count
        return Double(completed) / Double(categoryGuides.count)
    }
}
