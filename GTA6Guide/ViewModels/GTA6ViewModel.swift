import Foundation
import Combine
import SwiftUI

final class GTA6ViewModel: ObservableObject {
    @Published var guides: [Guide] = []
    @Published var cheatCodes: [CheatCode] = []
    @Published var vehicles: [Vehicle] = []
    @Published var weapons: [Weapon] = []
    @Published var mapPins: [MapPin] = []
    @Published var characters: [Character] = []
    @Published var newsItems: [NewsItem] = []
    @Published var triviaQuestions: [TriviaQuestion] = []
    
    // MARK: - Search & Filters
    @Published var guideSearchText: String = ""
    @Published var selectedGuideCategory: GuideCategory = .all
    @Published var selectedGuideDifficulty: GuideDifficulty? = nil
    @Published var showOnlyBookmarkedGuides: Bool = false
    
    @Published var cheatSearchText: String = ""
    @Published var selectedCheatCategory: CheatCategory = .all
    @Published var selectedPlatform: GamingPlatform = .ps5
    @Published var showOnlyFavoriteCheats: Bool = false
    
    @Published var selectedPinType: PinType = .all
    @Published var pinSearchText: String = ""
    
    @Published var selectedVehicleClass: VehicleClass = .all
    @Published var vehicleCompare1: Vehicle? = nil
    @Published var vehicleCompare2: Vehicle? = nil
    
    @Published var selectedWeaponCategory: WeaponCategory = .all
    
    // MARK: - Interactive Tools State
    
    // Heist Calculator
    @Published var heistTake: Double = 5000000
    @Published var heistApproach: String = "Smart Hacker"
    @Published var luciaCutPercent: Double = 35.0
    @Published var jasonCutPercent: Double = 35.0
    @Published var hackerCutPercent: Double = 10.0
    @Published var driverCutPercent: Double = 8.0
    @Published var gunmanCutPercent: Double = 7.0
    @Published var fencingFeePercent: Double = 5.0
    
    // Trivia Quiz Game
    @Published var currentTriviaIndex: Int = 0
    @Published var triviaScore: Int = 0
    @Published var selectedAnswerIndex: Int? = nil
    @Published var isAnswerSubmitted: Bool = false
    @Published var isQuizFinished: Bool = false
    @Published var triviaHighScore: Int = UserDefaults.standard.integer(forKey: "gta6_trivia_high_score")
    
    private let dataService = DataService.shared
    
    init() {
        loadData()
    }
    
    func loadData() {
        self.guides = dataService.fetchGuides()
        self.cheatCodes = dataService.fetchCheatCodes()
        self.vehicles = dataService.fetchVehicles()
        self.weapons = dataService.fetchWeapons()
        self.mapPins = dataService.fetchMapPins()
        self.characters = dataService.fetchCharacters()
        self.newsItems = dataService.fetchNews()
        self.triviaQuestions = dataService.fetchTriviaQuestions()
        
        if let firstVeh = vehicles.first {
            vehicleCompare1 = firstVeh
            vehicleCompare2 = vehicles.count > 1 ? vehicles[1] : firstVeh
        }
    }
    
    // MARK: - Filtered Guides
    
    var filteredGuides: [Guide] {
        guides.filter { guide in
            let matchesSearch = guideSearchText.isEmpty ||
                guide.title.localizedCaseInsensitiveContains(guideSearchText) ||
                guide.summary.localizedCaseInsensitiveContains(guideSearchText) ||
                guide.tags.contains(where: { $0.localizedCaseInsensitiveContains(guideSearchText) })
            
            let matchesCategory = selectedGuideCategory == .all || guide.category == selectedGuideCategory
            let matchesDifficulty = selectedGuideDifficulty == nil || guide.difficulty == selectedGuideDifficulty
            let matchesBookmark = !showOnlyBookmarkedGuides || guide.isBookmarked
            
            return matchesSearch && matchesCategory && matchesDifficulty && matchesBookmark
        }
    }
    
    var bookmarkedGuides: [Guide] {
        guides.filter { $0.isBookmarked }
    }
    
    // MARK: - Guide Actions
    
    func toggleGuideBookmark(for guide: Guide) {
        if let index = guides.firstIndex(where: { $0.id == guide.id }) {
            guides[index].isBookmarked.toggle()
            dataService.saveGuides(guides)
            Haptics.playImpact(.light)
        }
    }
    
    func toggleGuideCompletion(for guide: Guide) {
        if let index = guides.firstIndex(where: { $0.id == guide.id }) {
            guides[index].isCompleted.toggle()
            dataService.saveGuides(guides)
            Haptics.playNotification(.success)
        }
    }
    
    func toggleGuideStep(guideId: UUID, stepId: UUID) {
        if let gIndex = guides.firstIndex(where: { $0.id == guideId }),
           let sIndex = guides[gIndex].steps.firstIndex(where: { $0.id == stepId }) {
            guides[gIndex].steps[sIndex].isCompleted.toggle()
            
            // If all steps completed, automatically mark guide completed
            let allDone = guides[gIndex].steps.allSatisfy { $0.isCompleted }
            if allDone {
                guides[gIndex].isCompleted = true
            }
            dataService.saveGuides(guides)
            Haptics.playImpact(.medium)
        }
    }
    
    func saveGuideUserNotes(guideId: UUID, notes: String) {
        if let index = guides.firstIndex(where: { $0.id == guideId }) {
            guides[index].userNotes = notes
            dataService.saveGuides(guides)
        }
    }
    
    // MARK: - Filtered Cheat Codes
    
    var filteredCheatCodes: [CheatCode] {
        cheatCodes.filter { cheat in
            let matchesSearch = cheatSearchText.isEmpty ||
                cheat.title.localizedCaseInsensitiveContains(cheatSearchText) ||
                cheat.description.localizedCaseInsensitiveContains(cheatSearchText) ||
                cheat.pcInput.localizedCaseInsensitiveContains(cheatSearchText)
            
            let matchesCategory = selectedCheatCategory == .all || cheat.category == selectedCheatCategory
            let matchesFavorite = !showOnlyFavoriteCheats || cheat.isFavorite
            
            return matchesSearch && matchesCategory && matchesFavorite
        }
    }
    
    func toggleCheatFavorite(for cheat: CheatCode) {
        if let index = cheatCodes.firstIndex(where: { $0.id == cheat.id }) {
            cheatCodes[index].isFavorite.toggle()
            dataService.saveCheatCodes(cheatCodes)
            Haptics.playImpact(.light)
        }
    }
    
    func copyCheatCode(_ cheat: CheatCode, platform: GamingPlatform) {
        var copyString = ""
        switch platform {
        case .ps5: copyString = cheat.ps5Input
        case .xbox: copyString = cheat.xboxInput
        case .pc: copyString = cheat.pcInput
        case .phone: copyString = cheat.phoneInput
        }
        UIPasteboard.general.string = copyString
        Haptics.playNotification(.success)
    }
    
    // MARK: - Filtered Map Pins
    
    var filteredMapPins: [MapPin] {
        mapPins.filter { pin in
            let matchesSearch = pinSearchText.isEmpty ||
                pin.title.localizedCaseInsensitiveContains(pinSearchText) ||
                pin.subtitle.localizedCaseInsensitiveContains(pinSearchText) ||
                pin.description.localizedCaseInsensitiveContains(pinSearchText)
            
            let matchesType = selectedPinType == .all || pin.type == selectedPinType
            return matchesSearch && matchesType
        }
    }
    
    func togglePinCompletion(for pin: MapPin) {
        if let index = mapPins.firstIndex(where: { $0.id == pin.id }) {
            mapPins[index].isCompleted.toggle()
            dataService.saveMapPins(mapPins)
            Haptics.playImpact(.medium)
        }
    }
    
    // MARK: - Filtered Vehicles & Weapons
    
    var filteredVehicles: [Vehicle] {
        vehicles.filter { vehicle in
            selectedVehicleClass == .all || vehicle.vehicleClass == selectedVehicleClass
        }
    }
    
    var filteredWeapons: [Weapon] {
        weapons.filter { weapon in
            selectedWeaponCategory == .all || weapon.category == selectedWeaponCategory
        }
    }
    
    // MARK: - Heist Calculations
    
    var totalCutsPercentage: Double {
        luciaCutPercent + jasonCutPercent + hackerCutPercent + driverCutPercent + gunmanCutPercent + fencingFeePercent
    }
    
    var luciaPayout: Double { (heistTake * (luciaCutPercent / 100.0)) }
    var jasonPayout: Double { (heistTake * (jasonCutPercent / 100.0)) }
    var hackerPayout: Double { (heistTake * (hackerCutPercent / 100.0)) }
    var driverPayout: Double { (heistTake * (driverCutPercent / 100.0)) }
    var gunmanPayout: Double { (heistTake * (gunmanCutPercent / 100.0)) }
    var fencingPayout: Double { (heistTake * (fencingFeePercent / 100.0)) }
    
    // MARK: - Trivia Quiz Logic
    
    var currentQuestion: TriviaQuestion? {
        guard currentTriviaIndex < triviaQuestions.count else { return nil }
        return triviaQuestions[currentTriviaIndex]
    }
    
    func submitTriviaAnswer(_ index: Int) {
        guard !isAnswerSubmitted, let question = currentQuestion else { return }
        selectedAnswerIndex = index
        isAnswerSubmitted = true
        
        if index == question.correctOptionIndex {
            triviaScore += 100
            Haptics.playNotification(.success)
        } else {
            Haptics.playNotification(.error)
        }
        
        if triviaScore > triviaHighScore {
            triviaHighScore = triviaScore
            UserDefaults.standard.set(triviaHighScore, forKey: "gta6_trivia_high_score")
        }
    }
    
    func nextTriviaQuestion() {
        selectedAnswerIndex = nil
        isAnswerSubmitted = false
        if currentTriviaIndex + 1 < triviaQuestions.count {
            currentTriviaIndex += 1
        } else {
            isQuizFinished = true
        }
    }
    
    func resetTriviaQuiz() {
        currentTriviaIndex = 0
        triviaScore = 0
        selectedAnswerIndex = nil
        isAnswerSubmitted = false
        isQuizFinished = false
    }
    
    // MARK: - Progress Stats
    
    var overallProgress: Double {
        let totalGuides = guides.count
        let totalPins = mapPins.count
        let total = totalGuides + totalPins
        guard total > 0 else { return 0 }
        
        let completedGuides = guides.filter { $0.isCompleted }.count
        let completedPins = mapPins.filter { $0.isCompleted }.count
        
        return Double(completedGuides + completedPins) / Double(total)
    }
    
    func progress(for category: GuideCategory) -> Double {
        let categoryGuides = guides.filter { $0.category == category }
        guard !categoryGuides.isEmpty else { return 0 }
        
        let completed = categoryGuides.filter { $0.isCompleted }.count
        return Double(completed) / Double(categoryGuides.count)
    }
}
