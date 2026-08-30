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

            MapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
                .tag(2)

            CheatCodesView()
                .tabItem {
                    Label("Cheats", systemImage: "keyboard.fill")
                }
                .tag(3)

            MoreView()
                .tabItem {
                    Label("More", systemImage: "ellipsis")
                }
                .tag(4)
        }
        .accentColor(.neonPink)
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
