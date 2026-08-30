import SwiftUI

struct OnboardingView: View {
    @Binding var showOnboarding: Bool
    
    var body: some View {
        TabView {
            OnboardingPage(title: "Welcome to Leonida", description: "Your ultimate GTA 6 companion app.", icon: "map.fill")
            OnboardingPage(title: "Explore the Map", description: "Discover secrets with our interactive map.", icon: "magnifyingglass.circle.fill")
            OnboardingPage(title: "Master the Game", description: "Use our guides and cheats to dominate.", icon: "keyboard.fill")
            
            Button("Get Started") {
                showOnboarding = false
            }
            .font(.headline)
            .padding()
            .background(Color.neonPink)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .tabViewStyle(PageTabViewStyle())
        .background(Color.viceBackground.ignoresSafeArea())
    }
}

struct OnboardingPage: View {
    let title: String
    let description: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: icon)
                .font(.system(size: 80))
                .foregroundColor(.neonPink)
            
            Text(title)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
            
            Text(description)
                .font(.body)
                .foregroundColor(.slateGray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}
