import SwiftUI

struct RemoteImageView: View {
    let urlString: String
    let fallbackSystemName: String
    let contentMode: ContentMode
    
    init(urlString: String, fallbackSystemName: String = "photo.fill", contentMode: ContentMode = .fill) {
        self.urlString = urlString
        self.fallbackSystemName = fallbackSystemName
        self.contentMode = contentMode
    }
    
    var body: some View {
        if let url = URL(string: urlString), !urlString.isEmpty {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Color.deepPurple.opacity(0.4)
                        ProgressView()
                            .tint(.neonPink)
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                case .failure:
                    fallbackView
                @unknown default:
                    fallbackView
                }
            }
        } else {
            fallbackView
        }
    }
    
    private var fallbackView: some View {
        ZStack {
            LinearGradient(
                colors: [Color.deepPurple.opacity(0.8), Color.viceBackground],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            Image(systemName: fallbackSystemName)
                .font(.system(size: 32))
                .foregroundColor(.slateGray.opacity(0.6))
        }
    }
}
