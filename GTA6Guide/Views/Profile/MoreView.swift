import SwiftUI
import StoreKit

struct MoreView: View {
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    moreRow(title: "Characters", icon: "person.2.fill", destination: CharactersView())
                }
                
                Section {
                    Button(action: {
                        if let url = URL(string: "https://www.youtube.com/watch?v=tJbzMqJGH4k") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Label("Watch Official Trailer", systemImage: "play.rectangle.fill")
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        if let url = URL(string: "https://gta6-guite.up.railway.app/privacy.html") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Label("Privacy Policy", systemImage: "lock.shield")
                            .foregroundColor(.white)
                    }

                    Button(action: {
                        if let url = URL(string: "https://gta6-guite.up.railway.app/terms.html") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Label("Terms of Use", systemImage: "doc.text")
                            .foregroundColor(.white)
                    }
                    Button(action: {
                        if let url = URL(string: "mailto:michaelwhitaker872@gmail.com") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Label("Contact Us", systemImage: "envelope")
                            .foregroundColor(.white)
                    }
                    Button(action: {
                        requestReview()
                    }) {
                        Label("Rate Us", systemImage: "star")
                            .foregroundColor(.white)
                    }
                }
            }
            .navigationTitle("More")
            .listStyle(InsetGroupedListStyle())
            .background(Color.viceBackground.ignoresSafeArea())
        }
    }
    
    private func moreRow<Content: View>(title: String, icon: String, destination: Content) -> some View {
        NavigationLink(destination: destination) {
            Label(title, systemImage: icon)
                .foregroundColor(.white)
        }
    }
}

// Temporary view for Profile Details
struct ProfileDetailsView: View {
    var body: some View {
        Text("User Profile Details")
            .navigationTitle("Profile")
    }
}
