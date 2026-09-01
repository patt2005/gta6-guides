import SwiftUI

struct CompletionCategory: Identifiable {
    let id: String
    let name: String
    let iconName: String
    let colorHex: String
    let totalItems: Int
    var completedItems: Int
    let requirements: [String]
}

struct CompletionTrackerView: View {
    @AppStorage("story_completed_count") private var storyCount: Int = 12
    @AppStorage("strangers_completed_count") private var strangersCount: Int = 5
    @AppStorage("hobbies_completed_count") private var hobbiesCount: Int = 8
    @AppStorage("random_completed_count") private var randomCount: Int = 4
    @AppStorage("collectibles_completed_count") private var collectiblesCount: Int = 14
    
    private let totalStory = 60
    private let totalStrangers = 20
    private let totalHobbies = 42
    private let totalRandom = 14
    private let totalCollectibles = 50
    
    var totalAll: Int { totalStory + totalStrangers + totalHobbies + totalRandom + totalCollectibles }
    var completedAll: Int { storyCount + strangersCount + hobbiesCount + randomCount + collectiblesCount }
    var percentageAll: Double { Double(completedAll) / Double(totalAll) }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header radial ring card
                CustomCard {
                    HStack(spacing: 20) {
                        // Radial Ring
                        ZStack {
                            Circle()
                                .stroke(Color.slateGray.opacity(0.3), lineWidth: 10)
                                .frame(width: 90, height: 90)
                            
                            Circle()
                                .trim(from: 0, to: CGFloat(percentageAll))
                                .stroke(
                                    LinearGradient(colors: [.neonPink, .viceCyan], startPoint: .topLeading, endPoint: .bottomTrailing),
                                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                                )
                                .frame(width: 90, height: 90)
                                .rotationEffect(.degrees(-90))
                            
                            VStack(spacing: 0) {
                                Text("\(Int(percentageAll * 100))%")
                                    .font(.title3)
                                    .fontWeight(.black)
                                    .foregroundColor(.white)
                                Text("100% GOAL")
                                    .font(.system(size: 8, weight: .bold))
                                    .foregroundColor(.viceCyan)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("LEONIDA 100% COMPLETION")
                                .font(.caption2)
                                .fontWeight(.black)
                                .foregroundColor(.viceCyan)
                                .tracking(1.2)
                            
                            Text("\(completedAll) of \(totalAll) Tasks")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("Track all storyline heists, strangers, mini-games, and hidden items required for 100% completion.")
                                .font(.caption2)
                                .foregroundColor(.slateGray)
                        }
                    }
                    .padding(6)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Text("CATEGORIES BREAKDOWN")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.slateGray)
                    .tracking(1.5)
                    .padding(.horizontal)
                
                // Categories
                VStack(spacing: 12) {
                    CategoryTrackerRow(
                        title: "Story Missions & Heists",
                        icon: "flag.checkered",
                        colorHex: "FF2E63",
                        current: $storyCount,
                        total: totalStory,
                        items: ["Prologue Escape", "Vice City Reunion", "The Port Gellhorn Score", "Ocean Drive Takeover", "Final Heist Showdown"]
                    )
                    
                    CategoryTrackerRow(
                        title: "Strangers & Freaks Encounters",
                        icon: "person.3.fill",
                        colorHex: "00F0FF",
                        current: $strangersCount,
                        total: totalStrangers,
                        items: ["Leonida Mud Bogging Cult", "Starfish Island Paparazzi", "Swamp Smuggler Hermit", "Vice City Art Collector"]
                    )
                    
                    CategoryTrackerRow(
                        title: "Hobbies & Pastimes",
                        icon: "gamecontroller.fill",
                        colorHex: "FFBE0B",
                        current: $hobbiesCount,
                        total: totalHobbies,
                        items: ["Street Racing Circuits (6)", "Tennis Matches", "Shooting Range Gold Medals", "Nightclub Dancing VIP", "Airboat Swamp Slalom"]
                    )
                    
                    CategoryTrackerRow(
                        title: "Random Open World Events",
                        icon: "exclamationmark.bubble.fill",
                        colorHex: "FF6B6B",
                        current: $randomCount,
                        total: totalRandom,
                        items: ["ATM Robbery Interventions", "High-Speed Highway Chases", "Swamp Breakdown Rescues", "Shoplifter Apprehensions"]
                    )
                    
                    CategoryTrackerRow(
                        title: "Collectibles & Hidden Stashes",
                        icon: "star.fill",
                        colorHex: "00E676",
                        current: $collectiblesCount,
                        total: totalCollectibles,
                        items: ["50 Neon Rooftop Signs", "20 Submerged Smuggler Caches", "30 Stunt Jump Ramps", "15 Rare Wildlife Photos"]
                    )
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .background(Color.viceBackground.ignoresSafeArea())
        .navigationTitle("100% Tracker")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CategoryTrackerRow: View {
    let title: String
    let icon: String
    let colorHex: String
    @Binding var current: Int
    let total: Int
    let items: [String]
    
    @State private var isExpanded: Bool = false
    
    var progress: Double { Double(current) / Double(total) }
    
    var body: some View {
        CustomCard {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(Color(hex: colorHex))
                        .font(.title3)
                    
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("\(current)/\(total)")
                        .font(.caption)
                        .fontWeight(.black)
                        .foregroundColor(Color(hex: colorHex))
                }
                
                ProgressBar(progress: progress, height: 6)
                
                HStack {
                    Button(action: {
                        if current > 0 { current -= 1; Haptics.playImpact(.light) }
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.slateGray)
                            .font(.title3)
                    }
                    
                    Button(action: {
                        if current < total { current += 1; Haptics.playNotification(.success) }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color(hex: colorHex))
                            .font(.title3)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation { isExpanded.toggle() }
                    }) {
                        HStack(spacing: 4) {
                            Text(isExpanded ? "Hide Requirements" : "View Requirements")
                                .font(.caption2)
                                .foregroundColor(.slateGray)
                            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                .font(.caption2)
                                .foregroundColor(.slateGray)
                        }
                    }
                }
                
                if isExpanded {
                    VStack(alignment: .leading, spacing: 6) {
                        Divider().background(Color.cardBorder)
                        Text("KEY MILESTONES:")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(.slateGray)
                        
                        ForEach(items, id: \.self) { item in
                            HStack(spacing: 6) {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 5))
                                    .foregroundColor(Color(hex: colorHex))
                                Text(item)
                                    .font(.caption2)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                        }
                    }
                    .padding(.top, 4)
                }
            }
        }
    }
}
