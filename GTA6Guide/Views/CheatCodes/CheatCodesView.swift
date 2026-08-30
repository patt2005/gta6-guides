import SwiftUI

struct CheatCodesView: View {
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(viewModel.cheatCodes) { cheat in
                    CheatCodeRow(cheat: cheat)
                }
            }
            .padding()
        }
        .background(Color.viceBackground.ignoresSafeArea())
        .navigationTitle("Cheat Codes")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CheatCodeRow: View {
    let cheat: CheatCode
    
    var body: some View {
        CustomCard {
            VStack(alignment: .leading, spacing: 10) {
                Text(cheat.title.uppercased())
                    .font(.headline)
                    .foregroundColor(.neonPink)
                
                Text(cheat.description)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                
                Divider().background(Color.slateGray.opacity(0.3))
                
                VStack(alignment: .leading, spacing: 5) {
                    inputField(label: "PS5", input: cheat.ps5Input)
                    inputField(label: "Xbox", input: cheat.xboxInput)
                    inputField(label: "PC", input: cheat.pcInput)
                }
            }
        }
    }
    
    private func inputField(label: String, input: String) -> some View {
        HStack {
            Text(label)
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(.slateGray)
                .frame(width: 40, alignment: .leading)
            
            Text(input)
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(.white)
        }
    }
}
