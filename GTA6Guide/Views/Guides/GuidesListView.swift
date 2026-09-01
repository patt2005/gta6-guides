import SwiftUI

struct GuidesListView: View {
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    private let columns = [
        GridItem(.adaptive(minimum: 320), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                searchBar
                
                // Category Filter Pills (includes Saved)
                categoryFilter
                
                // Guides Grid / List
                ScrollView {
                    if viewModel.filteredGuides.isEmpty {
                        emptyStateView
                    } else {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.filteredGuides) { guide in
                                NavigationLink(destination: GuideDetailView(guide: guide)) {
                                    GuideGridCard(guide: guide)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                }
            }
            .background(Color.viceBackground.ignoresSafeArea())
            .navigationTitle("Game Guides")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 6) {
                        Image(systemName: "book.closed.fill")
                            .foregroundColor(.neonPink)
                        Text("LEONIDA GUIDES")
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
            
            TextField("Search missions, heists, weapons, secrets...", text: $viewModel.guideSearchText)
                .foregroundColor(.white)
            
            if !viewModel.guideSearchText.isEmpty {
                Button(action: { viewModel.guideSearchText = "" }) {
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
    
    private var categoryFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(GuideCategory.allCases) { category in
                    Button(action: {
                        viewModel.selectedGuideCategory = category
                        viewModel.showOnlyBookmarkedGuides = false
                        Haptics.playImpact(.light)
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: category.iconName)
                                .font(.caption2)
                            Text(category.rawValue)
                                .font(.caption)
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background((viewModel.selectedGuideCategory == category && !viewModel.showOnlyBookmarkedGuides) ? Color.neonPink : Color.darkCard)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke((viewModel.selectedGuideCategory == category && !viewModel.showOnlyBookmarkedGuides) ? Color.clear : Color.cardBorder, lineWidth: 1)
                        )
                    }
                }
                
                // Saved / Bookmarked Filter Pill
                Button(action: {
                    viewModel.showOnlyBookmarkedGuides.toggle()
                    Haptics.playImpact(.light)
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: viewModel.showOnlyBookmarkedGuides ? "bookmark.fill" : "bookmark")
                            .font(.caption2)
                        Text("Saved")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(viewModel.showOnlyBookmarkedGuides ? Color.neonPink : Color.darkCard)
                    .foregroundColor(viewModel.showOnlyBookmarkedGuides ? .black : .white)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(viewModel.showOnlyBookmarkedGuides ? Color.clear : Color.cardBorder, lineWidth: 1)
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
            Image(systemName: "doc.text.magnifyingglass")
                .font(.system(size: 50))
                .foregroundColor(.slateGray.opacity(0.5))
            
            Text("No Guides Found")
                .font(.headline)
                .foregroundColor(.white)
            
            Text("Try clearing your search query or selecting another category filter.")
                .font(.caption)
                .foregroundColor(.slateGray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Reset Filters") {
                viewModel.guideSearchText = ""
                viewModel.selectedGuideCategory = .all
                viewModel.selectedGuideDifficulty = nil
                viewModel.showOnlyBookmarkedGuides = false
            }
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.neonPink)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.neonPink.opacity(0.1))
            .cornerRadius(8)
            
            Spacer(minLength: 40)
        }
        .padding()
    }
}

struct GuideGridCard: View {
    let guide: Guide
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image Thumbnail
            ZStack(alignment: .topTrailing) {
                RemoteImageView(urlString: guide.imageUrl, fallbackSystemName: "book.fill")
                    .frame(height: 140)
                    .clipped()
                
                // Top Badges
                HStack {
                    CategoryBadge(category: guide.category.rawValue)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.toggleGuideBookmark(for: guide)
                    }) {
                        Image(systemName: guide.isBookmarked ? "bookmark.fill" : "bookmark")
                            .foregroundColor(.neonPink)
                            .padding(6)
                            .background(Color.darkCard.opacity(0.8))
                            .clipShape(Circle())
                    }
                }
                .padding(8)
            }
            
            // Card Body
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(guide.difficulty.rawValue.uppercased())
                        .font(.system(size: 9, weight: .black))
                        .foregroundColor(Color(hex: guide.difficulty.colorHex))
                    
                    Spacer()
                    
                    Label("\(guide.readingTime) min", systemImage: "clock")
                        .font(.system(size: 10))
                        .foregroundColor(.slateGray)
                }
                
                Text(guide.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                Text(guide.summary)
                    .font(.caption)
                    .foregroundColor(.slateGray)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                // Steps Progress
                if !guide.steps.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Progress: \(guide.completedStepsCount)/\(guide.steps.count) steps")
                                .font(.system(size: 10))
                                .foregroundColor(.viceCyan)
                            Spacer()
                            if guide.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.viceGreen)
                                    .font(.caption2)
                            }
                        }
                        ProgressBar(progress: guide.stepsProgress, height: 4)
                    }
                    .padding(.top, 4)
                }
            }
            .padding(12)
        }
        .background(Color.darkCard)
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(guide.isCompleted ? Color.viceGreen.opacity(0.5) : Color.cardBorder, lineWidth: 1)
        )
    }
}
