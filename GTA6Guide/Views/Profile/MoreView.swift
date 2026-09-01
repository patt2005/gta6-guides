import SwiftUI
import StoreKit

struct MoreView: View {
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        List {
            Section(header: Text("LORE & COMPANION EXTENSIONS").foregroundColor(.slateGray)) {
                NavigationLink(destination: CharactersView()) {
                    Label("Characters & Factions", systemImage: "person.2.fill")
                        .foregroundColor(.white)
                }
            }
            .listRowBackground(Color.darkCard)
            
            Section(header: Text("OFFICIAL & COMMUNITY").foregroundColor(.slateGray)) {
                Button(action: {
                    if let url = URL(string: "https://www.youtube.com/watch?v=tJbzMqJGH4k") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Label("Watch Official Trailer", systemImage: "play.rectangle.fill")
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    requestReview()
                }) {
                    Label("Rate App on App Store", systemImage: "star.fill")
                        .foregroundColor(.viceGold)
                }
            }
            .listRowBackground(Color.darkCard)
            
            Section(header: Text("LEGAL & SUPPORT").foregroundColor(.slateGray)) {
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
                    Label("Contact Support", systemImage: "envelope")
                        .foregroundColor(.white)
                }
            }
            .listRowBackground(Color.darkCard)
            
            Section(footer: disclaimerFooter) {
                EmptyView()
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(InsetGroupedListStyle())
        .background(Color.viceBackground.ignoresSafeArea())
        .scrollContentBackground(.hidden)
    }
    
    private var disclaimerFooter: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("DISCLAIMER")
                .font(.system(size: 9, weight: .bold))
                .foregroundColor(.slateGray)
            
            Text("Guides for GTA 6 is an unofficial reference companion app created by fans for informational and educational purposes. Grand Theft Auto, GTA VI, Rockstar Games, and Take-Two Interactive are trademarks or registered trademarks of Take-Two Interactive Software, Inc. All rights reserved.")
                .font(.system(size: 9))
                .foregroundColor(.slateGray.opacity(0.7))
                .lineSpacing(2)
            
            Text("Version 1.1.0 • Build 2026.09")
                .font(.system(size: 9, weight: .bold))
                .foregroundColor(.slateGray.opacity(0.5))
                .padding(.top, 4)
        }
        .padding(.vertical, 8)
    }
}
