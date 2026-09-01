import SwiftUI

struct CharactersView: View {
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    private let columns = [
        GridItem(.adaptive(minimum: 340), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("LEONIDA CHARACTERS & FACTIONS")
                            .font(.caption2)
                            .fontWeight(.black)
                            .foregroundColor(.viceCyan)
                            .tracking(1.5)
                        
                        Text("Key Underworld Players")
                            .font(.title2)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                        
                        Text("Detailed biographies, combat abilities, preferred weapons, and signature vehicles.")
                            .font(.caption)
                            .foregroundColor(.slateGray)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.characters) { character in
                            CharacterCard(character: character)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
            .background(Color.viceBackground.ignoresSafeArea())
        }
    }
}

struct CharacterCard: View {
    let character: Character
    
    var body: some View {
        CustomCard {
            VStack(alignment: .leading, spacing: 14) {
                // Top Bio Header
                HStack(spacing: 16) {
                    Image(character.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.neonPink, lineWidth: 2))
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text(character.role.uppercased())
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(.neonPink)
                        
                        Text(character.name.uppercased())
                            .font(.title3)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                            .tracking(1)
                        
                        Text(character.faction)
                            .font(.caption2)
                            .foregroundColor(.viceCyan)
                    }
                }
                
                Text(character.description)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.85))
                    .lineSpacing(2)
                
                if !character.backstory.isEmpty {
                    Text(character.backstory)
                        .font(.caption2)
                        .foregroundColor(.slateGray)
                        .lineSpacing(2)
                }
                
                // Abilities
                VStack(alignment: .leading, spacing: 6) {
                    Text("SPECIAL ABILITIES")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.slateGray)
                    
                    HStack(spacing: 6) {
                        ForEach(character.abilities, id: \.self) { ability in
                            Text(ability)
                                .font(.system(size: 10, weight: .semibold))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.neonPink.opacity(0.15))
                                .foregroundColor(.neonPink)
                                .cornerRadius(4)
                        }
                    }
                }
                
                // Preferred Weapons & Signature Vehicle
                if !character.preferredWeapons.isEmpty || !character.signatureVehicle.isEmpty {
                    VStack(alignment: .leading, spacing: 6) {
                        if !character.preferredWeapons.isEmpty {
                            HStack(alignment: .top, spacing: 6) {
                                Image(systemName: "scope")
                                    .font(.system(size: 10))
                                    .foregroundColor(.viceGold)
                                Text("Weapons: \(character.preferredWeapons.joined(separator: ", "))")
                                    .font(.system(size: 10))
                                    .foregroundColor(.white.opacity(0.8))
                            }
                        }
                        
                        if !character.signatureVehicle.isEmpty {
                            HStack(alignment: .top, spacing: 6) {
                                Image(systemName: "car.fill")
                                    .font(.system(size: 10))
                                    .foregroundColor(.viceCyan)
                                Text("Vehicle: \(character.signatureVehicle)")
                                    .font(.system(size: 10))
                                    .foregroundColor(.white.opacity(0.8))
                            }
                        }
                    }
                }
                
                Divider().background(Color.cardBorder)
                
                // Stats
                VStack(alignment: .leading, spacing: 8) {
                    Text("CHARACTER ATTRIBUTES")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.slateGray)
                    
                    ForEach(character.stats.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        VStack(alignment: .leading, spacing: 2) {
                            HStack {
                                Text(key)
                                    .font(.system(size: 10))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("\(Int(value * 100))%")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.viceCyan)
                            }
                            ProgressBar(progress: value, height: 4)
                        }
                    }
                }
            }
        }
    }
}
