import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @AppStorage("hasShownOnboarding") var hasShownOnboarding: Bool = false
    @State private var showOnboarding: Bool = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            GuidesListView()
                .tabItem {
                    Label("Guides", systemImage: "book.fill")
                }
                .tag(1)
            
            CheatCodesView()
                .tabItem {
                    Label("Cheats", systemImage: "gamecontroller.fill")
                }
                .tag(2)
            
            ToolsHubView()
                .tabItem {
                    Label("Tools", systemImage: "wrench.and.screwdriver.fill")
                }
                .tag(3)
            
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
                .tag(4)
        }
        .tint(.neonPink)
        .onAppear {
            if !hasShownOnboarding {
                showOnboarding = true
                hasShownOnboarding = true
            }
        }
        .sheet(isPresented: $showOnboarding) {
            OnboardingView(showOnboarding: $showOnboarding)
        }
    }
}
