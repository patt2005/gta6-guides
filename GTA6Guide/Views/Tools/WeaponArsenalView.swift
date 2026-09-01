import SwiftUI

struct WeaponArsenalView: View {
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    @State private var selectedWeapon: Weapon? = nil
    @State private var targetDistanceMeters: Double = 15.0
    @State private var targetBodyPart: String = "Torso"
    
    private let bodyParts = ["Headshot", "Torso", "Limbs"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("BALLISTICS & WEAPON ARSENAL")
                        .font(.caption2)
                        .fontWeight(.black)
                        .foregroundColor(.viceCyan)
                        .tracking(1.5)
                    
                    Text("Firearm Database")
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    
                    Text("Analyze weapon telemetry, attachments, and simulate shots-to-kill distances.")
                        .font(.caption)
                        .foregroundColor(.slateGray)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Category Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(WeaponCategory.allCases) { category in
                            Button(action: {
                                viewModel.selectedWeaponCategory = category
                                Haptics.playImpact(.light)
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: category.iconName)
                                        .font(.caption2)
                                    Text(category.rawValue)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(viewModel.selectedWeaponCategory == category ? Color.viceGold : Color.darkCard)
                                .foregroundColor(viewModel.selectedWeaponCategory == category ? .black : .white)
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 1)
                }
                
                // Weapons List / Selector
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(viewModel.filteredWeapons) { weapon in
                            Button(action: {
                                selectedWeapon = weapon
                                Haptics.playImpact(.light)
                            }) {
                                WeaponPillCard(weapon: weapon, isSelected: (selectedWeapon?.id == weapon.id || (selectedWeapon == nil && viewModel.weapons.first?.id == weapon.id)))
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Selected Weapon Details & Ballistics Visualizer
                if let weapon = selectedWeapon ?? viewModel.weapons.first {
                    VStack(alignment: .leading, spacing: 16) {
                        // Weapon Card
                        CustomCard {
                            VStack(alignment: .leading, spacing: 14) {
                                HStack(alignment: .top) {
                                    RemoteImageView(urlString: weapon.imageUrl, fallbackSystemName: "scope")
                                        .frame(width: 90, height: 70)
                                        .cornerRadius(8)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(weapon.category.rawValue.uppercased())
                                            .font(.caption2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.viceGold)
                                        
                                        Text(weapon.name)
                                            .font(.headline)
                                            .fontWeight(.black)
                                            .foregroundColor(.white)
                                        
                                        Text("Price: $\(weapon.price.formatted()) • Mag: \(weapon.magazineCapacity) rds")
                                            .font(.caption2)
                                            .foregroundColor(.viceGreen)
                                    }
                                }
                                
                                Divider().background(Color.cardBorder)
                                
                                // Stats
                                statBar(title: "Damage", value: weapon.damage, colorHex: "FF2E63")
                                statBar(title: "Fire Rate", value: weapon.fireRate, colorHex: "00F0FF")
                                statBar(title: "Accuracy", value: weapon.accuracy, colorHex: "FFBE0B")
                                statBar(title: "Effective Range", value: weapon.range, colorHex: "00E676")
                                
                                // Attachments
                                if !weapon.attachments.isEmpty {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("COMPATIBLE ATTACHMENTS")
                                            .font(.system(size: 10, weight: .bold))
                                            .foregroundColor(.slateGray)
                                        
                                        HStack {
                                            ForEach(weapon.attachments, id: \.self) { att in
                                                Text(att)
                                                    .font(.system(size: 10, weight: .semibold))
                                                    .padding(.horizontal, 8)
                                                    .padding(.vertical, 4)
                                                    .background(Color.deepPurple.opacity(0.6))
                                                    .foregroundColor(.white)
                                                    .cornerRadius(4)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        // Interactive Damage & Shots to Kill Simulator
                        CustomCard {
                            VStack(alignment: .leading, spacing: 14) {
                                HStack {
                                    Image(systemName: "target")
                                        .foregroundColor(.neonPink)
                                    Text("SHOTS-TO-KILL SIMULATOR")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                
                                // Body Part Picker
                                HStack(spacing: 8) {
                                    ForEach(bodyParts, id: \.self) { part in
                                        Button(action: {
                                            targetBodyPart = part
                                            Haptics.playImpact(.light)
                                        }) {
                                            Text(part)
                                                .font(.caption)
                                                .fontWeight(.bold)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 6)
                                                .background(targetBodyPart == part ? Color.neonPink : Color.darkCard)
                                                .foregroundColor(targetBodyPart == part ? .black : .white)
                                                .cornerRadius(8)
                                        }
                                    }
                                }
                                
                                // Distance Slider
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text("Engagement Distance:")
                                            .font(.caption2)
                                            .foregroundColor(.slateGray)
                                        Spacer()
                                        Text("\(Int(targetDistanceMeters)) meters")
                                            .font(.caption2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.viceCyan)
                                    }
                                    
                                    Slider(value: $targetDistanceMeters, in: 5...100, step: 5)
                                        .tint(.viceCyan)
                                }
                                
                                Divider().background(Color.cardBorder)
                                
                                // Calculated Shots to Kill
                                HStack {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("ESTIMATED SHOTS TO NEUTRALIZE")
                                            .font(.system(size: 9, weight: .bold))
                                            .foregroundColor(.slateGray)
                                        Text("\(calculateShotsToKill(weapon: weapon, part: targetBodyPart, distance: targetDistanceMeters)) Rounds")
                                            .font(.title2)
                                            .fontWeight(.black)
                                            .foregroundColor(.viceGreen)
                                    }
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .trailing, spacing: 2) {
                                        Text("TIME TO KILL (TTK)")
                                            .font(.system(size: 9, weight: .bold))
                                            .foregroundColor(.slateGray)
                                        Text(calculateTTK(weapon: weapon, part: targetBodyPart, distance: targetDistanceMeters))
                                            .font(.title3)
                                            .fontWeight(.black)
                                            .foregroundColor(.viceCyan)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                Spacer(minLength: 30)
            }
        }
        .background(Color.viceBackground.ignoresSafeArea())
        .navigationTitle("Arsenal")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func statBar(title: String, value: Double, colorHex: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .font(.caption2)
                    .foregroundColor(.white)
                Spacer()
                Text("\(Int(value * 100))%")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: colorHex))
            }
            ProgressBar(progress: value, height: 6)
        }
    }
    
    private func calculateShotsToKill(weapon: Weapon, part: String, distance: Double) -> Int {
        var baseShots = Int(ceil((1.0 - weapon.damage) * 6.0)) + 1
        if part == "Headshot" {
            baseShots = max(1, Int(ceil(Double(baseShots) * 0.25)))
        } else if part == "Limbs" {
            baseShots += 2
        }
        if distance > 40 {
            let dropoff = Int(distance / 25.0)
            baseShots += dropoff
        }
        return max(1, baseShots)
    }
    
    private func calculateTTK(weapon: Weapon, part: String, distance: Double) -> String {
        let shots = calculateShotsToKill(weapon: weapon, part: part, distance: distance)
        let rate = max(0.2, weapon.fireRate)
        let seconds = Double(shots) * (0.6 / (rate * 5.0))
        return String(format: "%.2fs", seconds)
    }
}

struct WeaponPillCard: View {
    let weapon: Weapon
    let isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            RemoteImageView(urlString: weapon.imageUrl, fallbackSystemName: "scope")
                .frame(width: 120, height: 75)
                .cornerRadius(8)
            
            Text(weapon.name)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(isSelected ? .viceGold : .white)
                .lineLimit(1)
            
            Text(weapon.category.rawValue)
                .font(.system(size: 9))
                .foregroundColor(.slateGray)
        }
        .padding(8)
        .background(Color.darkCard)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.viceGold : Color.cardBorder, lineWidth: isSelected ? 2 : 1)
        )
    }
}
