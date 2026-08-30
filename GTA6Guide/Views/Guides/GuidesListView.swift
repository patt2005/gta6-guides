import SwiftUI

struct GuidesListView: View {
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                searchBar
                
                categoryFilter
                
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(viewModel.filteredGuides) { guide in
                            NavigationLink(destination: GuideDetailView(guide: guide)) {
                                GuideRow(guide: guide)
                            }
                        }
                    }
                    .padding()
                }
            }
            .background(Color.viceBackground.ignoresSafeArea())
            .navigationTitle("Guides")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("GUIDES")
                        .font(.headline)
                        .foregroundColor(.white)
                        .tracking(3)
                }
            }
        }
    }
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.slateGray)
            
            TextField("Search guides...", text: $viewModel.searchText)
                .foregroundColor(.white)
            
            if !viewModel.searchText.isEmpty {
                Button(action: { viewModel.searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.slateGray)
                }
            }
        }
        .padding(12)
        .background(Color.deepPurple.opacity(0.5))
        .cornerRadius(10)
        .padding()
    }
    
    private var categoryFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                filterButton(title: "All", category: nil)
                
                ForEach(GuideCategory.allCases, id: \.self) { category in
                    filterButton(title: category.rawValue, category: category)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
    }
    
    private func filterButton(title: String, category: GuideCategory?) -> some View {
        Button(action: { viewModel.selectedCategory = category }) {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(viewModel.selectedCategory == category ? Color.neonPink : Color.deepPurple.opacity(0.3))
                .foregroundColor(viewModel.selectedCategory == category ? .black : .white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.neonPink, lineWidth: viewModel.selectedCategory == category ? 0 : 1)
                )
        }
    }
}

struct GuideRow: View {
    let guide: Guide
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    var body: some View {
        CustomCard {
            HStack(alignment: .top, spacing: 15) {
                VStack(alignment: .leading, spacing: 8) {
                    CategoryBadge(category: guide.category.rawValue)
                    
                    Text(guide.title)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(guide.summary)
                        .font(.caption)
                        .foregroundColor(.slateGray)
                        .lineLimit(2)
                    
                    HStack {
                        Label("\(guide.readingTime) min", systemImage: "clock")
                            .font(.caption2)
                            .foregroundColor(.slateGray)
                        
                        Spacer()
                        
                        if guide.isCompleted {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.neonPink)
                        }
                        
                        if guide.isBookmarked {
                            Image(systemName: "bookmark.fill")
                                .foregroundColor(.neonPink)
                        }
                    }
                    .padding(.top, 4)
                }
                
                Spacer()
            }
        }
    }
}
