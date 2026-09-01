import SwiftUI

struct CheatCodesView: View {
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    private let columns = [
        GridItem(.adaptive(minimum: 340), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                searchBar
                
                // Platform Selector
                platformSelector
                
                // Cheats Grid / List
                ScrollView {
                    if viewModel.filteredCheatCodes.isEmpty {
                        emptyStateView
                    } else {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.filteredCheatCodes) { cheat in
                                NavigationLink(destination: CheatCodeDetailView(cheat: cheat)) {
                                    CheatCodeCard(cheat: cheat, platform: viewModel.selectedPlatform)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                }
            }
            .background(Color.viceBackground.ignoresSafeArea())
            .navigationTitle("Cheat Codes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 6) {
                        Image(systemName: "gamecontroller.fill")
                            .foregroundColor(.viceCyan)
                        Text("CHEAT VAULT")
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
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.slateGray)
            
            TextField("Search cheat name, effect, code...", text: $viewModel.cheatSearchText)
                .foregroundColor(.white)
            
            if !viewModel.cheatSearchText.isEmpty {
                Button(action: { viewModel.cheatSearchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.slateGray)
                }
            }
        }
        .padding(12)
        .background(Color.darkCard)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.cardBorder, lineWidth: 1))
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    private var platformSelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(GamingPlatform.allCases) { platform in
                    Button(action: {
                        viewModel.selectedPlatform = platform
                        Haptics.playImpact(.light)
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: platform.iconName)
                                .font(.caption2)
                            Text(platform.shortName)
                                .font(.caption)
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(viewModel.selectedPlatform == platform ? Color.viceCyan : Color.darkCard)
                        .foregroundColor(viewModel.selectedPlatform == platform ? .black : .white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(viewModel.selectedPlatform == platform ? Color.clear : Color.cardBorder, lineWidth: 1)
                        )
                    }
                }
                
                // Favorites toggle
                Button(action: {
                    viewModel.showOnlyFavoriteCheats.toggle()
                    Haptics.playImpact(.light)
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: viewModel.showOnlyFavoriteCheats ? "heart.fill" : "heart")
                            .font(.caption2)
                        Text("Favs")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(viewModel.showOnlyFavoriteCheats ? Color.neonPink.opacity(0.2) : Color.darkCard)
                    .foregroundColor(viewModel.showOnlyFavoriteCheats ? Color.neonPink : Color.slateGray)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(viewModel.showOnlyFavoriteCheats ? Color.neonPink.opacity(0.5) : Color.cardBorder, lineWidth: 1)
                    )
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Spacer(minLength: 40)
            Image(systemName: "gamecontroller")
                .font(.system(size: 50))
                .foregroundColor(.slateGray.opacity(0.5))
            
            Text("No Cheat Codes Found")
                .font(.headline)
                .foregroundColor(.white)
            
            Text("Try clearing your search query.")
                .font(.caption)
                .foregroundColor(.slateGray)
                .multilineTextAlignment(.center)
            
            Button("Reset Search") {
                viewModel.cheatSearchText = ""
                viewModel.showOnlyFavoriteCheats = false
            }
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.viceCyan)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.viceCyan.opacity(0.1))
            .cornerRadius(8)
            
            Spacer(minLength: 40)
        }
        .padding()
    }
}

struct CheatCodeCard: View {
    let cheat: CheatCode
    let platform: GamingPlatform
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    @State private var copied: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                CategoryBadge(category: cheat.category.rawValue)
                
                Spacer()
                
                Button(action: {
                    viewModel.toggleCheatFavorite(for: cheat)
                }) {
                    Image(systemName: cheat.isFavorite ? "heart.fill" : "heart")
                        .font(.subheadline)
                        .foregroundColor(.neonPink)
                }
            }
            
            Text(cheat.title.uppercased())
                .font(.headline)
                .fontWeight(.black)
                .foregroundColor(.white)
                .tracking(1)
            
            Text(cheat.description)
                .font(.caption)
                .foregroundColor(.slateGray)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            Divider().background(Color.cardBorder)
            
            // Buttons Sequence Display
            HStack(alignment: .center) {
                switch platform {
                case .ps5:
                    ControllerSequenceView(buttons: cheat.ps5Buttons, isPlaystation: true)
                case .xbox:
                    ControllerSequenceView(buttons: cheat.xboxButtons, isPlaystation: false)
                case .pc:
                    Text(cheat.pcInput)
                        .font(.system(size: 15, weight: .black, design: .monospaced))
                        .foregroundColor(.viceGreen)
                case .phone:
                    HStack(spacing: 4) {
                        Image(systemName: "phone.fill")
                            .font(.caption2)
                            .foregroundColor(.viceCyan)
                        Text(cheat.phoneInput)
                            .font(.system(size: 13, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                // 1-Tap Copy Button
                Button(action: {
                    viewModel.copyCheatCode(cheat, platform: platform)
                    withAnimation {
                        copied = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation {
                            copied = false
                        }
                    }
                }) {
                    Image(systemName: copied ? "checkmark.circle.fill" : "doc.on.doc")
                        .font(.caption)
                        .foregroundColor(copied ? .viceGreen : .viceCyan)
                        .padding(8)
                        .background((copied ? Color.viceGreen : Color.viceCyan).opacity(0.15))
                        .clipShape(Circle())
                }
            }
        }
        .padding(14)
        .background(Color.darkCard)
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.cardBorder, lineWidth: 1)
        )
    }
}
