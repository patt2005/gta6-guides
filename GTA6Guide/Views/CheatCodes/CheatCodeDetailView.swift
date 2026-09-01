import SwiftUI

struct CheatCodeDetailView: View {
    let cheat: CheatCode
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    @State private var selectedPlatform: GamingPlatform = .ps5
    @State private var showCopiedAlert: Bool = false
    
    var currentCheat: CheatCode {
        viewModel.cheatCodes.first(where: { $0.id == cheat.id }) ?? cheat
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Banner
                ZStack(alignment: .bottomLeading) {
                    RemoteImageView(urlString: currentCheat.imageUrl, fallbackSystemName: "keyboard.fill")
                        .frame(height: 200)
                        .clipped()
                    
                    LinearGradient(
                        colors: [.clear, Color.viceBackground.opacity(0.8), Color.viceBackground],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            CategoryBadge(category: currentCheat.category.rawValue)
                            Spacer()
                            Button(action: {
                                viewModel.toggleCheatFavorite(for: currentCheat)
                            }) {
                                Image(systemName: currentCheat.isFavorite ? "heart.fill" : "heart")
                                    .font(.title3)
                                    .foregroundColor(.neonPink)
                                    .padding(8)
                                    .background(Color.darkCard.opacity(0.8))
                                    .clipShape(Circle())
                            }
                        }
                        
                        Text(currentCheat.title.uppercased())
                            .font(.system(size: 26, weight: .black))
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                
                // Platform Switcher Tabs
                VStack(alignment: .leading, spacing: 10) {
                    Text("SELECT PLATFORM INPUT")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.slateGray)
                        .tracking(1.2)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(GamingPlatform.allCases) { platform in
                                Button(action: {
                                    selectedPlatform = platform
                                    Haptics.playImpact(.light)
                                }) {
                                    HStack(spacing: 6) {
                                        Image(systemName: platform.iconName)
                                            .font(.caption2)
                                        Text(platform.shortName)
                                            .font(.caption)
                                            .fontWeight(.bold)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(selectedPlatform == platform ? Color.viceCyan : Color.darkCard)
                                    .foregroundColor(selectedPlatform == platform ? .black : .white)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(selectedPlatform == platform ? Color.clear : Color.cardBorder, lineWidth: 1)
                                    )
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Code Input Visualizer Box
                CustomCard {
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Text("\(selectedPlatform.rawValue.uppercased()) CODE")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.viceCyan)
                                .tracking(1.2)
                            
                            Spacer()
                            
                            Button(action: {
                                viewModel.copyCheatCode(currentCheat, platform: selectedPlatform)
                                withAnimation {
                                    showCopiedAlert = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        showCopiedAlert = false
                                    }
                                }
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: showCopiedAlert ? "checkmark.circle.fill" : "doc.on.doc.fill")
                                    Text(showCopiedAlert ? "Copied!" : "Copy")
                                }
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(showCopiedAlert ? .viceGreen : .neonPink)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background((showCopiedAlert ? Color.viceGreen : Color.neonPink).opacity(0.15))
                                .cornerRadius(8)
                            }
                        }
                        
                        // Visualized buttons / text
                        switch selectedPlatform {
                        case .ps5:
                            ControllerSequenceView(buttons: currentCheat.ps5Buttons, isPlaystation: true)
                        case .xbox:
                            ControllerSequenceView(buttons: currentCheat.xboxButtons, isPlaystation: false)
                        case .pc:
                            HStack {
                                Text(currentCheat.pcInput)
                                    .font(.system(size: 22, weight: .black, design: .monospaced))
                                    .foregroundColor(.viceGreen)
                                    .padding(.vertical, 8)
                                Spacer()
                            }
                        case .phone:
                            HStack(spacing: 8) {
                                Image(systemName: "phone.fill")
                                    .foregroundColor(.viceCyan)
                                Text(currentCheat.phoneInput)
                                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.vertical, 6)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("EFFECTS & DETAILS")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.slateGray)
                        .tracking(1.2)
                    
                    Text(currentCheat.description)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
                        .lineSpacing(4)
                    
                    if !currentCheat.effects.isEmpty {
                        VStack(alignment: .leading, spacing: 6) {
                            ForEach(currentCheat.effects, id: \.self) { effect in
                                HStack(alignment: .top, spacing: 8) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.caption)
                                        .foregroundColor(.viceGreen)
                                        .padding(.top, 2)
                                    Text(effect)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.85))
                                }
                            }
                        }
                        .padding(.top, 6)
                    }
                }
                .padding(.horizontal)
                
                // Activation Tips Card
                CustomCard {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.viceCyan)
                            Text("HOW TO ACTIVATE")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        
                        Text(currentCheat.tips)
                            .font(.caption)
                            .foregroundColor(.slateGray)
                            .lineSpacing(3)
                    }
                }
                .padding(.horizontal)
                
                // Warning Box
                if let warning = currentCheat.warning {
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.title3)
                            .foregroundColor(.sunsetOrange)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("TROPHY / ACHIEVEMENT NOTICE")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.sunsetOrange)
                            Text(warning)
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.8))
                                .lineSpacing(2)
                        }
                    }
                    .padding()
                    .background(Color.sunsetOrange.opacity(0.1))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.sunsetOrange.opacity(0.4), lineWidth: 1))
                    .padding(.horizontal)
                }
                
                // Big Copy Button
                Button(action: {
                    viewModel.copyCheatCode(currentCheat, platform: selectedPlatform)
                    withAnimation {
                        showCopiedAlert = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            showCopiedAlert = false
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: showCopiedAlert ? "checkmark.seal.fill" : "doc.on.doc.fill")
                        Text(showCopiedAlert ? "COPIED TO CLIPBOARD" : "COPY \(selectedPlatform.shortName.uppercased()) CODE")
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(showCopiedAlert ? Color.viceGreen : Color.viceCyan)
                    .cornerRadius(12)
                    .shadow(color: Color.viceCyan.opacity(0.3), radius: 6)
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .background(Color.viceBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }
}
