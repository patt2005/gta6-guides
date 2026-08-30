import Foundation
import Combine

class DataService {
    static let shared = DataService()
    
    private let guidesKey = "gta6_guides"
    private let pinsKey = "gta6_pins"
    
    func fetchGuides() -> [Guide] {
        if let data = UserDefaults.standard.data(forKey: guidesKey),
           let decoded = try? JSONDecoder().decode([Guide].self, from: data) {
            return decoded
        }
        return createInitialGuides()
    }
    
    func saveGuides(_ guides: [Guide]) {
        if let encoded = try? JSONEncoder().encode(guides) {
            UserDefaults.standard.set(encoded, forKey: guidesKey)
        }
    }
    
    func fetchMapPins() -> [MapPin] {
        if let data = UserDefaults.standard.data(forKey: pinsKey),
           let decoded = try? JSONDecoder().decode([MapPin].self, from: data) {
            return decoded
        }
        return createInitialPins()
    }
    
    func fetchCheatCodes() -> [CheatCode] {
        return [
            CheatCode(title: "Invincibility", description: "Makes you invincible for 5 minutes.", category: .player, ps5Input: "→ X → ← → R1 → ← X △", xboxInput: "→ A → ← → RB → ← A Y", pcInput: "PAINKILLER"),
            CheatCode(title: "Max Health & Armor", description: "Full health and armor.", category: .player, ps5Input: "○ L1 △ R2 X □ ○ → □ L1 L1 L1", xboxInput: "B LB Y RT A X B → X LB LB LB", pcInput: "TURTLE"),
            CheatCode(title: "Raise Wanted Level", description: "Increases your wanted level.", category: .combat, ps5Input: "→ → □ R2 ← R1 → ← → ← →", xboxInput: "→ → X RT ← RB → ← → ← →", pcInput: "FUGITIVE")
        ]
    }
    
    func saveMapPins(_ pins: [MapPin]) {
        if let encoded = try? JSONEncoder().encode(pins) {
            UserDefaults.standard.set(encoded, forKey: pinsKey)
        }
    }
    
    func fetchCharacters() -> [Character] {
        return [
            Character(name: "Lucia", description: "A street-smart criminal navigating the neon-soaked underworld of Vice City.", abilities: ["Hacking", "Precision Driving"], stats: ["Stamina": 0.7, "Shooting": 0.6, "Driving": 0.9], imageName: "lucia"),
            Character(name: "Jason", description: "A former small-town drifter caught up in a high-stakes life of crime.", abilities: ["Melee Combat", "Tactical Stealth"], stats: ["Stamina": 0.8, "Shooting": 0.9, "Driving": 0.7], imageName: "jason")
        ]
    }
    
    func fetchNews() -> [NewsItem] {
        return [
            NewsItem(title: "Trailer 1 Surpasses 200M Views", summary: "The first official look at GTA VI continues to break records across the internet.", content: "The first trailer for Grand Theft Auto VI shattered records within hours of its release. Fans from across the globe have spent countless hours analyzing every frame for secrets and hints about the upcoming game."),
            NewsItem(title: "Rockstar Confirms Fall 2025 Release", summary: "Parent company Take-Two interactive narrows down the release window in latest earnings call.", content: "Take-Two Interactive has officially narrowed the release window for GTA VI to the Fall of 2025. This highly anticipated title is set to take players back to the beloved setting of Vice City and beyond."),
            NewsItem(title: "Mapping Leonida State", summary: "Fans are piecing together the largest map in Rockstar history based on trailer footage.", content: "Based on the official reveal trailer, dedicated fans have begun constructing detailed maps of Leonida State, highlighting the massive scale of the new environment.")
        ]
    }
    
    private func createInitialGuides() -> [Guide] {
        return [
            Guide(title: "Getting Started in Vice City", category: .general, summary: "A beginner's guide to Leonida State.", content: "Vice City is bigger and more detailed than ever. Start by exploring the beach areas...", readingTime: 5),
            Guide(title: "The Lucia & Jason Dynamic", category: .missions, summary: "How to switch characters and use their unique abilities.", content: "The dual-protagonist system allows for tactical advantages during missions...", readingTime: 8),
            Guide(title: "Hidden Collectibles: Neon Signs", category: .collectibles, summary: "Find all 50 neon signs hidden across the city.", content: "Leonida is full of secrets. Neon signs are often found on top of motels...", readingTime: 12),
            Guide(title: "Top 5 Fast Cars", category: .vehicles, summary: "The fastest vehicles for getaways.", content: "Looking for speed? Here are the top 5 cars you can find or purchase in Leonida...", readingTime: 6),
            Guide(title: "Mastering Melee Combat", category: .activities, summary: "Combat techniques for close encounters.", content: "Melee in GTA 6 is more responsive. Learn combos and counter-attacks...", readingTime: 7),
            Guide(title: "Weapon Locations", category: .weapons, summary: "Where to find powerful weaponry early on.", content: "High-tier weapons are guarded. Here are strategic locations to check...", readingTime: 10),
            Guide(title: "Nightlife Guide", category: .activities, summary: "Best clubs and activities in the city.", content: "Vice City comes alive at night. Check out these hotspots...", readingTime: 4)
        ]
    }
    
    private func createInitialPins() -> [MapPin] {
        return [
            MapPin(title: "Ocean View Hotel", type: .safehouse, coordinate: CGPoint(x: 0.8, y: 0.6)),
            MapPin(title: "Ammu-Nation Downtown", type: .weapon, coordinate: CGPoint(x: 0.4, y: 0.3)),
            MapPin(title: "Hidden Package #1", type: .collectible, coordinate: CGPoint(x: 0.2, y: 0.8)),
            MapPin(title: "Street Race: Beach Front", type: .activity, coordinate: CGPoint(x: 0.9, y: 0.5))
        ]
    }
}
