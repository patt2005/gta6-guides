import SwiftUI

struct CategoryBadge: View {
    let category: String
    
    var body: some View {
        Text(category.uppercased())
            .font(.caption2)
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.neonPink.opacity(0.2))
            .foregroundColor(.neonPink)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.neonPink, lineWidth: 1)
            )
    }
}
