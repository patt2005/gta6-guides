import SwiftUI

struct ToolsHubView: View {
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    private let columns = [
        GridItem(.adaptive(minimum: 320), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header Banner
                    headerBanner
                    
                    Text("INTERACTIVE UTILITIES & SIMULATORS")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.slateGray)
                        .tracking(1.5)
                        .padding(.horizontal)
                    
                    // Grid of Tools
                    LazyVGrid(columns: columns, spacing: 16) {
                        NavigationLink(destination: HeistCalculatorView()) {
                            ToolCard(
                                title: "Heist Payout & Cut Calculator",
                                subtitle: "Simulate crew splits, take amounts, and maximize net profits.",
                                iconName: "dollarsign.circle.fill",
                                colorHex: "00F0FF",
                                badge: "Interactive"
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: VehicleCompareView()) {
                            ToolCard(
                                title: "Vehicle Garage & Side-by-Side Compare",
                                subtitle: "Compare top speed, acceleration, handling, and tuning stats.",
                                iconName: "bolt.car.fill",
                                colorHex: "FF2E63",
                                badge: "Comparison Tool"
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: WeaponArsenalView()) {
                            ToolCard(
                                title: "Weapon Arsenal & Damage Calculator",
                                subtitle: "Explore firearm statistics, attachments, and shots-to-kill ranges.",
                                iconName: "scope",
                                colorHex: "FFBE0B",
                                badge: "Ballistics"
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: CompletionTrackerView()) {
                            ToolCard(
                                title: "100% Leonida Completion Tracker",
                                subtitle: "Track missions, random encounters, collectibles, and activities.",
                                iconName: "checkmark.seal.fill",
                                colorHex: "00E676",
                                badge: "Progress Checklist"
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
            .background(Color.viceBackground.ignoresSafeArea())
            .navigationTitle("Tools")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 6) {
                        Image(systemName: "wrench.and.screwdriver.fill")
                            .foregroundColor(.neonPink)
                        Text("LEONIDA TOOLS")
                            .font(.headline)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                            .tracking(2)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var headerBanner: some View {
        ZStack(alignment: .bottomLeading) {
            Image("banner")
                .resizable()
                .scaledToFill()
                .frame(height: 140)
                .clipped()
                .overlay(
                    LinearGradient(
                        colors: [Color.black.opacity(0.4), Color.viceBackground],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text("TACTICAL COMPANION SUITE")
                    .font(.caption2)
                    .fontWeight(.black)
                    .foregroundColor(.viceCyan)
                    .tracking(2)
                
                Text("Tools Built For Leonida")
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.white)
            }
            .padding()
        }
    }
}

struct ToolCard: View {
    let title: String
    let subtitle: String
    let iconName: String
    let colorHex: String
    let badge: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: iconName)
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(Color(hex: colorHex))
                .frame(width: 52, height: 52)
                .background(Color(hex: colorHex).opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: colorHex).opacity(0.4), lineWidth: 1))
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .lineLimit(2)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.slateGray)
                }
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.slateGray)
                    .lineLimit(2)
                
                Text(badge.uppercased())
                    .font(.system(size: 9, weight: .black))
                    .foregroundColor(Color(hex: colorHex))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color(hex: colorHex).opacity(0.1))
                    .cornerRadius(4)
                    .padding(.top, 2)
            }
        }
        .padding(14)
        .background(Color.darkCard)
        .cornerRadius(14)
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.cardBorder, lineWidth: 1))
    }
}
