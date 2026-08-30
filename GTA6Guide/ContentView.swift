import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @AppStorage("hasShownOnboarding") var hasShownOnboarding: Bool = false
    @State private var showOnboarding: Bool = false
    @State private var cachedSizeClass: UserInterfaceSizeClass = .compact
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
                .environment(\.horizontalSizeClass, cachedSizeClass)
                .transformEnvironment(\.horizontalSizeClass) { sizeClass in
                    sizeClass = .compact
                }
            
            GuidesListView()
                .tabItem {
                    Label("Guides", systemImage: "book.fill")
                }
                .tag(1)
                .environment(\.horizontalSizeClass, cachedSizeClass)
                .transformEnvironment(\.horizontalSizeClass) { sizeClass in
                    sizeClass = .compact
                }
            
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
                .tag(2)
                .environment(\.horizontalSizeClass, cachedSizeClass)
                .transformEnvironment(\.horizontalSizeClass) { sizeClass in
                    sizeClass = .compact
                }
            
            CheatCodesView()
                .tabItem {
                    Label("Cheats", systemImage: "keyboard.fill")
                }
                .tag(3)
                .environment(\.horizontalSizeClass, cachedSizeClass)
                .transformEnvironment(\.horizontalSizeClass) { sizeClass in
                    sizeClass = .compact
                }
            
            MoreView()
                .tabItem {
                    Label("More", systemImage: "ellipsis")
                }
                .tag(4)
                .environment(\.horizontalSizeClass, cachedSizeClass)
                .transformEnvironment(\.horizontalSizeClass) { sizeClass in
                    sizeClass = .compact
                }
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
