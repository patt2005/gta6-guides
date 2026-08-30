import SwiftUI

struct CharactersView: View {
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(viewModel.characters) { character in
                    CharacterCard(character: character)
                }
            }
            .padding()
        }
        .background(Color.viceBackground.ignoresSafeArea())
        .navigationTitle("Characters")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CharacterCard: View {
    let character: Character
    
    var body: some View {
        CustomCard {
            VStack(alignment: .leading, spacing: 15) {
                HStack(spacing: 20) {
                    Image(character.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.neonPink, lineWidth: 2))

                VStack(alignment: .leading, spacing: 4) {
                        Text(character.name.uppercased())
                            .font(.title2)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                            .tracking(2)
                        
                        Text("Protagonist")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.neonPink)
                    }
                }
                
                Text(character.description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("ABILITIES")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.slateGray)
                    
                    HStack {
                        ForEach(character.abilities, id: \.self) { ability in
                            Text(ability)
                                .font(.caption2)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.neonPink.opacity(0.1))
                                .foregroundColor(.neonPink)
                                .cornerRadius(5)
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("STATS")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.slateGray)
                    
                    ForEach(character.stats.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(key)
                                    .font(.caption2)
                                    .foregroundColor(.white)
                                Spacer()
                                Text("\(Int(value * 100))%")
                                    .font(.caption2)
                                    .foregroundColor(.neonPink)
                            }
                            ProgressBar(progress: value, height: 6)
                        }
                    }
                }
            }
        }
    }
}
