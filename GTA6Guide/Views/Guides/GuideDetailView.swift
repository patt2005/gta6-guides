import SwiftUI

struct GuideDetailView: View {
    let guide: Guide
    @EnvironmentObject var viewModel: GTA6ViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 12) {
                    CategoryBadge(category: guide.category.rawValue)
                    
                    Text(guide.title)
                        .font(.system(size: 32, weight: .black))
                        .foregroundColor(.white)
                    
                    HStack {
                        Label("\(guide.readingTime) min read", systemImage: "clock")
                            .font(.caption)
                            .foregroundColor(.slateGray)
                        
                        Spacer()
                        
                        Button(action: { viewModel.toggleBookmark(for: guide) }) {
                            Image(systemName: guide.isBookmarked ? "bookmark.fill" : "bookmark")
                                .foregroundColor(.neonPink)
                        }
                    }
                }
                .padding(.top)
                
                Divider().background(Color.slateGray.opacity(0.3))
                
                // Content
                Text(guide.content)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
                    .lineSpacing(6)
                
                Spacer(minLength: 50)
                
                // Footer Action
                Button(action: {
                    viewModel.toggleCompletion(for: guide)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(guide.isCompleted ? "MARK AS INCOMPLETE" : "MARK AS COMPLETED")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(guide.isCompleted ? Color.slateGray : Color.neonPink)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .background(Color.viceBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }
}
