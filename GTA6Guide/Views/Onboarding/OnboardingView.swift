import SwiftUI

struct OnboardingView: View {
    @Binding var showOnboarding: Bool
    @State private var selectedPage: Int = 0
    private let totalPages = 4
    
    var body: some View {
        ZStack {
            // Ambient Dark Synthwave Background
            Color.viceBackground.ignoresSafeArea()
            
            // Ambient Glowing Neon Orbs
            GeometryReader { geo in
                ZStack {
                    Circle()
                        .fill(Color.neonPink.opacity(0.18))
                        .frame(width: 280, height: 280)
                        .blur(radius: 80)
                        .offset(x: selectedPage % 2 == 0 ? -geo.size.width * 0.3 : geo.size.width * 0.3,
                                y: -geo.size.height * 0.2)
                        .animation(.easeInOut(duration: 0.8), value: selectedPage)
                    
                    Circle()
                        .fill(Color.viceCyan.opacity(0.15))
                        .frame(width: 300, height: 300)
                        .blur(radius: 90)
                        .offset(x: selectedPage % 2 == 0 ? geo.size.width * 0.3 : -geo.size.width * 0.3,
                                y: geo.size.height * 0.3)
                        .animation(.easeInOut(duration: 0.8), value: selectedPage)
                }
            }
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Navigation Bar (Branding & Skip)
                topBar
                
                // Paged Carousel
                TabView(selection: $selectedPage) {
                    WelcomeOnboardingSlide()
                        .tag(0)
                    
                    GuidesOnboardingSlide()
                        .tag(1)
                    
                    CheatsOnboardingSlide()
                        .tag(2)
                    
                    ToolsOnboardingSlide()
                        .tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Bottom Section: Custom Dots Indicator & Action Button
                bottomControls
            }
        }
    }
    
    // MARK: - Top Bar
    
    private var topBar: some View {
        HStack {
            HStack(spacing: 6) {
                Image(systemName: "flame.fill")
                    .font(.caption)
                    .foregroundColor(.neonPink)
                Text("GTA VI COMPANION")
                    .font(.system(size: 11, weight: .black))
                    .foregroundColor(.white)
                    .tracking(2)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color.darkCard.opacity(0.8))
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.cardBorder, lineWidth: 1))
            
            Spacer()
            
            Button(action: {
                Haptics.playNotification(.success)
                showOnboarding = false
            }) {
                Text("SKIP")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.slateGray)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 14)
    }
    
    // MARK: - Bottom Controls
    
    private var bottomControls: some View {
        VStack(spacing: 20) {
            // Animated Dots Indicator
            HStack(spacing: 8) {
                ForEach(0..<totalPages, id: \.self) { index in
                    Capsule()
                        .fill(selectedPage == index ? Color.neonPink : Color.cardBorder)
                        .frame(width: selectedPage == index ? 24 : 8, height: 8)
                        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedPage)
                }
            }
            
            // Action Button
            Button(action: {
                if selectedPage < totalPages - 1 {
                    withAnimation {
                        selectedPage += 1
                    }
                    Haptics.playImpact(.light)
                } else {
                    Haptics.playNotification(.success)
                    showOnboarding = false
                }
            }) {
                HStack(spacing: 8) {
                    Text(selectedPage == totalPages - 1 ? "ENTER VICE CITY" : "CONTINUE")
                        .font(.headline)
                        .fontWeight(.black)
                        .tracking(1)
                    
                    Image(systemName: selectedPage == totalPages - 1 ? "arrow.right.circle.fill" : "chevron.right")
                        .font(.headline)
                }
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    LinearGradient(
                        colors: selectedPage == totalPages - 1 ? [.neonPink, .sunsetOrange, .viceGold] : [.viceCyan, .neonPink],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(16)
                .shadow(color: Color.neonPink.opacity(0.4), radius: 10, y: 4)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
    }
}

// MARK: - Slide 1: Welcome

struct WelcomeOnboardingSlide: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Dual Protagonists Showcase Visual
            ZStack {
                // Background Banner Glow
                Image("banner")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 280, height: 160)
                    .cornerRadius(20)
                    .overlay(Color.black.opacity(0.45))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                LinearGradient(colors: [.neonPink, .viceCyan], startPoint: .topLeading, endPoint: .bottomTrailing),
                                lineWidth: 1.5
                            )
                    )
                    .shadow(color: Color.neonPink.opacity(0.3), radius: 15)
                
                // Overlapping Character Avatars
                HStack(spacing: -20) {
                    Image("lucia")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 85, height: 85)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.neonPink, lineWidth: 3))
                        .shadow(color: Color.neonPink.opacity(0.6), radius: 8)
                    
                    Image("jason")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 85, height: 85)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.viceCyan, lineWidth: 3))
                        .shadow(color: Color.viceCyan.opacity(0.6), radius: 8)
                }
                .offset(y: 45)
            }
            .padding(.bottom, 30)
            
            // Text Header
            VStack(spacing: 8) {
                Text("THE NEXT-GEN COMPANION")
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(.viceCyan)
                    .tracking(2)
                
                Text("Welcome to Leonida")
                    .font(.system(size: 30, weight: .black))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text("Your definitive offline tactical guide for Grand Theft Auto VI. Complete walkthroughs, interactive tools, cheats, and world maps.")
                    .font(.subheadline)
                    .foregroundColor(.slateGray)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
                    .padding(.horizontal, 30)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

// MARK: - Slide 2: Interactive Guides

struct GuidesOnboardingSlide: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Visual Interactive Checklist Card Mockup
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    CategoryBadge(category: "Missions & Heists")
                    Spacer()
                    Label("6 min read", systemImage: "clock.fill")
                        .font(.system(size: 10))
                        .foregroundColor(.slateGray)
                }
                
                Text("The Ocean Drive Bank Breach")
                    .font(.headline)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                
                // Steps Preview
                VStack(spacing: 8) {
                    onboardingStepRow(number: 1, text: "Disable security lasers with Lucia", isDone: true)
                    onboardingStepRow(number: 2, text: "Position Jason on overwatch roof", isDone: true)
                    onboardingStepRow(number: 3, text: "Execute synchronized vault breach", isDone: false)
                }
                
                HStack {
                    Text("Checklist: 2/3 Steps")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.viceCyan)
                    Spacer()
                    Image(systemName: "bookmark.fill")
                        .foregroundColor(.neonPink)
                        .font(.caption)
                }
                .padding(.top, 2)
            }
            .padding(16)
            .background(Color.darkCard)
            .cornerRadius(18)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(
                        LinearGradient(colors: [.viceCyan, .neonPink], startPoint: .topLeading, endPoint: .bottomTrailing),
                        lineWidth: 1.5
                    )
            )
            .shadow(color: Color.viceCyan.opacity(0.2), radius: 15)
            .padding(.horizontal, 20)
            
            // Text Content
            VStack(spacing: 8) {
                Text("INTERACTIVE WALKTHROUGHS")
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(.neonPink)
                    .tracking(2)
                
                Text("Interactive Guides")
                    .font(.system(size: 30, weight: .black))
                    .foregroundColor(.white)
                
                Text("Check off mission steps in real-time as you play, save custom private player notes, and discover high-reward secret stashes.")
                    .font(.subheadline)
                    .foregroundColor(.slateGray)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
                    .padding(.horizontal, 30)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    private func onboardingStepRow(number: Int, text: String, isDone: Bool) -> some View {
        HStack(spacing: 10) {
            Image(systemName: isDone ? "checkmark.square.fill" : "square")
                .foregroundColor(isDone ? .neonPink : .slateGray)
                .font(.system(size: 15))
            
            Text(text)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(isDone ? .white : .slateGray)
                .strikethrough(isDone)
            
            Spacer()
        }
        .padding(8)
        .background(Color.viceBackground.opacity(0.6))
        .cornerRadius(8)
    }
}

// MARK: - Slide 3: Cheat Vault

struct CheatsOnboardingSlide: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Visual Cheat Code Mockup Card
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    CategoryBadge(category: "Player & Health")
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.neonPink)
                }
                
                Text("INVINCIBILITY (GOD MODE)")
                    .font(.headline)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                
                // Controller sequence preview with images
                HStack(spacing: 6) {
                    ControllerButtonView(buttonText: "→", isPlaystation: true)
                    ControllerButtonView(buttonText: "✕", isPlaystation: true)
                    ControllerButtonView(buttonText: "→", isPlaystation: true)
                    ControllerButtonView(buttonText: "←", isPlaystation: true)
                    ControllerButtonView(buttonText: "R1", isPlaystation: true)
                    ControllerButtonView(buttonText: "△", isPlaystation: true)
                }
                .padding(.vertical, 4)
                
                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: "doc.on.doc.fill")
                        Text("1-Tap Copy with Haptics")
                    }
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.viceCyan)
                    
                    Spacer()
                    
                    Text("PS5 • XBOX • PC • PHONE")
                        .font(.system(size: 8, weight: .black))
                        .foregroundColor(.slateGray)
                }
            }
            .padding(16)
            .background(Color.darkCard)
            .cornerRadius(18)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(
                        LinearGradient(colors: [.viceGold, .sunsetOrange], startPoint: .topLeading, endPoint: .bottomTrailing),
                        lineWidth: 1.5
                    )
            )
            .shadow(color: Color.viceGold.opacity(0.2), radius: 15)
            .padding(.horizontal, 20)
            
            // Text Content
            VStack(spacing: 8) {
                Text("NATIVE CONTROLLER BUTTONS")
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(.viceGold)
                    .tracking(2)
                
                Text("Visual Cheat Vault")
                    .font(.system(size: 30, weight: .black))
                    .foregroundColor(.white)
                
                Text("Crystal clear controller button sequences for PS5 and Xbox Series X|S, complete with 1-tap clipboard copying and haptic feedback.")
                    .font(.subheadline)
                    .foregroundColor(.slateGray)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
                    .padding(.horizontal, 30)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

// MARK: - Slide 4: Tactical Tools

struct ToolsOnboardingSlide: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // 2x2 Interactive Tools Showcase Grid
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                onboardingToolMini(icon: "dollarsign.circle.fill", title: "Heist Calculator", subtitle: "Simulate crew splits", colorHex: "00F0FF")
                onboardingToolMini(icon: "bolt.car.fill", title: "Compare Cars", subtitle: "0-60 & Top Speed", colorHex: "FF2E63")
                onboardingToolMini(icon: "scope", title: "Arsenal & TTK", subtitle: "Ballistics visualizer", colorHex: "FFBE0B")
                onboardingToolMini(icon: "checkmark.seal.fill", title: "100% Checklist", subtitle: "Mission tracker", colorHex: "00E676")
            }
            .padding(.horizontal, 24)
            
            // Text Content
            VStack(spacing: 8) {
                Text("SIMULATORS & CALCULATORS")
                    .font(.system(size: 10, weight: .black))
                    .foregroundColor(.viceGreen)
                    .tracking(2)
                
                Text("Tactical Utilities")
                    .font(.system(size: 30, weight: .black))
                    .foregroundColor(.white)
                
                Text("Optimize heist profits, compare vehicle telemetry side-by-side, test weapon shots-to-kill, and track 100% Leonida completion.")
                    .font(.subheadline)
                    .foregroundColor(.slateGray)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
                    .padding(.horizontal, 30)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    private func onboardingToolMini(icon: String, title: String, subtitle: String, colorHex: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(Color(hex: colorHex))
            
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .lineLimit(1)
            
            Text(subtitle)
                .font(.system(size: 9))
                .foregroundColor(.slateGray)
                .lineLimit(1)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.darkCard)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.cardBorder, lineWidth: 1))
    }
}
