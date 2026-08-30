import SwiftUI

struct CustomCard<Content: View>: View {
    let content: Content
    let backgroundImage: String?
    
    init(backgroundImage: String? = nil, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.backgroundImage = backgroundImage
    }
    
    var body: some View {
        content
            .padding(12)
            .background(
                Group {
                    if let image = backgroundImage {
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .ignoresSafeArea()
                            .overlay(Color.black.opacity(0.7))
                    } else {
                        Color.deepPurple.opacity(0.4)
                    }
                }
            )
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(LinearGradient(colors: [.neonPink, .sunsetOrange], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
            )
    }
}
