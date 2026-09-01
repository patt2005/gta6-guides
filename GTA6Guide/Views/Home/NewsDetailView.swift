import SwiftUI

struct NewsDetailView: View {
    let item: NewsItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                RemoteImageView(urlString: item.imageUrl, fallbackSystemName: "newspaper.fill")
                    .frame(height: 220)
                    .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        CategoryBadge(category: item.category)
                        Spacer()
                        Label("\(item.readTimeMinutes) min read", systemImage: "clock")
                            .font(.caption2)
                            .foregroundColor(.slateGray)
                    }
                    
                    Text(item.title)
                        .font(.system(size: 24, weight: .black))
                        .foregroundColor(.white)
                    
                    HStack {
                        Text(item.source)
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.viceCyan)
                        
                        Text("•")
                            .foregroundColor(.slateGray)
                        
                        Text(item.date, style: .date)
                            .font(.caption2)
                            .foregroundColor(.slateGray)
                    }
                }
                
                Divider().background(Color.cardBorder)
                
                Text(item.content)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
                    .lineSpacing(6)
                
                Spacer(minLength: 30)
            }
            .padding()
        }
        .background(Color.viceBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }
}
