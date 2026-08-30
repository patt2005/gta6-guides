import SwiftUI

struct NewsDetailView: View {
    let item: NewsItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(item.title)
                    .font(.system(size: 32, weight: .black))
                    .foregroundColor(.white)
                
                Text(item.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.neonPink)
                
                Text(item.content)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))
                    .lineSpacing(8)
                
                Spacer()
            }
            .padding()
        }
        .background(Color.viceBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }
}
