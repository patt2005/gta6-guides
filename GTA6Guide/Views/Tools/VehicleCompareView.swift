import SwiftUI

struct VehicleCompareView: View {
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    @State private var showingCompareMode: Bool = true
    @State private var selectedVehicleForDetail: Vehicle? = nil
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Mode Switcher
                Picker("Mode", selection: $showingCompareMode) {
                    Text("Side-by-Side Compare").tag(true)
                    Text("Browse Garage Catalog").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .padding(.top, 10)
                
                if showingCompareMode {
                    compareSection
                } else {
                    catalogSection
                }
            }
            .padding(.bottom, 30)
        }
        .background(Color.viceBackground.ignoresSafeArea())
        .navigationTitle("Vehicle Garage")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $selectedVehicleForDetail) { vehicle in
            VehicleDetailSheet(vehicle: vehicle)
        }
    }
    
    // MARK: - Compare Section
    
    private var compareSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("SIDE-BY-SIDE VEHICLE BENCHMARK")
                .font(.caption2)
                .fontWeight(.black)
                .foregroundColor(.viceCyan)
                .tracking(1.5)
                .padding(.horizontal)
            
            // Pickers for Vehicle 1 and Vehicle 2
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("VEHICLE A")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.neonPink)
                    
                    Menu {
                        ForEach(viewModel.vehicles) { vehicle in
                            Button(vehicle.name) {
                                viewModel.vehicleCompare1 = vehicle
                                Haptics.playImpact(.light)
                            }
                        }
                    } label: {
                        HStack {
                            Text(viewModel.vehicleCompare1?.name ?? "Select Vehicle")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .lineLimit(1)
                            Spacer()
                            Image(systemName: "chevron.up.chevron.down")
                                .font(.caption2)
                                .foregroundColor(.neonPink)
                        }
                        .padding(10)
                        .background(Color.darkCard)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.neonPink.opacity(0.6), lineWidth: 1))
                    }
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("VEHICLE B")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.viceCyan)
                    
                    Menu {
                        ForEach(viewModel.vehicles) { vehicle in
                            Button(vehicle.name) {
                                viewModel.vehicleCompare2 = vehicle
                                Haptics.playImpact(.light)
                            }
                        }
                    } label: {
                        HStack {
                            Text(viewModel.vehicleCompare2?.name ?? "Select Vehicle")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .lineLimit(1)
                            Spacer()
                            Image(systemName: "chevron.up.chevron.down")
                                .font(.caption2)
                                .foregroundColor(.viceCyan)
                        }
                        .padding(10)
                        .background(Color.darkCard)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.viceCyan.opacity(0.6), lineWidth: 1))
                    }
                }
            }
            .padding(.horizontal)
            
            // Side by Side Visual Comparison Cards
            if let v1 = viewModel.vehicleCompare1, let v2 = viewModel.vehicleCompare2 {
                CustomCard {
                    VStack(spacing: 16) {
                        // Vehicle Heads
                        HStack(alignment: .top, spacing: 12) {
                            VStack(spacing: 6) {
                                RemoteImageView(urlString: v1.imageUrl, fallbackSystemName: "car.fill")
                                    .frame(height: 80)
                                    .cornerRadius(8)
                                Text(v1.name)
                                    .font(.subheadline)
                                    .fontWeight(.black)
                                    .foregroundColor(.neonPink)
                                    .lineLimit(1)
                                Text(v1.vehicleClass.rawValue)
                                    .font(.caption2)
                                    .foregroundColor(.slateGray)
                            }
                            
                            VStack(spacing: 6) {
                                Text("VS")
                                    .font(.title3)
                                    .fontWeight(.black)
                                    .foregroundColor(.viceGold)
                                    .padding(.top, 25)
                            }
                            
                            VStack(spacing: 6) {
                                RemoteImageView(urlString: v2.imageUrl, fallbackSystemName: "car.fill")
                                    .frame(height: 80)
                                    .cornerRadius(8)
                                Text(v2.name)
                                    .font(.subheadline)
                                    .fontWeight(.black)
                                    .foregroundColor(.viceCyan)
                                    .lineLimit(1)
                                Text(v2.vehicleClass.rawValue)
                                    .font(.caption2)
                                    .foregroundColor(.slateGray)
                            }
                        }
                        
                        Divider().background(Color.cardBorder)
                        
                        // Performance Comparisons
                        StatCompareRow(label: "Top Speed", val1: v1.topSpeedMph / 250.0, text1: "\(Int(v1.topSpeedMph)) MPH", val2: v2.topSpeedMph / 250.0, text2: "\(Int(v2.topSpeedMph)) MPH")
                        StatCompareRow(label: "Acceleration", val1: v1.acceleration, text1: "\(Int(v1.acceleration * 100))%", val2: v2.acceleration, text2: "\(Int(v2.acceleration * 100))%")
                        StatCompareRow(label: "Braking", val1: v1.braking, text1: "\(Int(v1.braking * 100))%", val2: v2.braking, text2: "\(Int(v2.braking * 100))%")
                        StatCompareRow(label: "Handling", val1: v1.handling, text1: "\(Int(v1.handling * 100))%", val2: v2.handling, text2: "\(Int(v2.handling * 100))%")
                        StatCompareRow(label: "Armor / Durability", val1: v1.armor, text1: "\(Int(v1.armor * 100))%", val2: v2.armor, text2: "\(Int(v2.armor * 100))%")
                        
                        Divider().background(Color.cardBorder)
                        
                        // Price comparison
                        HStack {
                            Text(formatPrice(v1.price))
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.neonPink)
                            Spacer()
                            Text("BUY PRICE")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.slateGray)
                            Spacer()
                            Text(formatPrice(v2.price))
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.viceCyan)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    // MARK: - Catalog Section
    
    private var catalogSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Category Filter
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(VehicleClass.allCases) { vClass in
                        Button(action: {
                            viewModel.selectedVehicleClass = vClass
                            Haptics.playImpact(.light)
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: vClass.iconName)
                                    .font(.caption2)
                                Text(vClass.rawValue)
                                    .font(.caption)
                                    .fontWeight(.bold)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(viewModel.selectedVehicleClass == vClass ? Color.neonPink : Color.darkCard)
                            .foregroundColor(viewModel.selectedVehicleClass == vClass ? .black : .white)
                            .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            // Vehicle List
            ForEach(viewModel.filteredVehicles) { vehicle in
                Button(action: {
                    selectedVehicleForDetail = vehicle
                }) {
                    VehicleCatalogCard(vehicle: vehicle)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)
            }
        }
    }
    
    private func formatPrice(_ price: Int) -> String {
        if price == 0 { return "Stolen Only" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: price)) ?? "$\(price)"
    }
}

struct StatCompareRow: View {
    let label: String
    let val1: Double
    let text1: String
    let val2: Double
    let text2: String
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text(text1)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.neonPink)
                    .frame(width: 65, alignment: .leading)
                
                Spacer()
                
                Text(label)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(.white.opacity(0.8))
                
                Spacer()
                
                Text(text2)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.viceCyan)
                    .frame(width: 65, alignment: .trailing)
            }
            
            HStack(spacing: 8) {
                // Left bar
                GeometryReader { geo in
                    ZStack(alignment: .trailing) {
                        Rectangle().fill(Color.slateGray.opacity(0.2))
                        Rectangle().fill(Color.neonPink)
                            .frame(width: geo.size.width * min(1.0, CGFloat(val1)))
                    }
                    .cornerRadius(3)
                }
                .frame(height: 6)
                
                // Right bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Rectangle().fill(Color.slateGray.opacity(0.2))
                        Rectangle().fill(Color.viceCyan)
                            .frame(width: geo.size.width * min(1.0, CGFloat(val2)))
                    }
                    .cornerRadius(3)
                }
                .frame(height: 6)
            }
        }
    }
}

struct VehicleCatalogCard: View {
    let vehicle: Vehicle
    
    var body: some View {
        HStack(spacing: 14) {
            RemoteImageView(urlString: vehicle.imageUrl, fallbackSystemName: "car.fill")
                .frame(width: 100, height: 80)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(vehicle.vehicleClass.rawValue.uppercased())
                    .font(.system(size: 9, weight: .bold))
                    .foregroundColor(.viceCyan)
                
                Text(vehicle.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                HStack(spacing: 10) {
                    Label("\(Int(vehicle.topSpeedMph)) MPH", systemImage: "speedometer")
                        .font(.caption2)
                        .foregroundColor(.slateGray)
                    
                    Label(vehicle.drivetrain, systemImage: "gearshape.2.fill")
                        .font(.caption2)
                        .foregroundColor(.slateGray)
                }
                
                Text(vehicle.price > 0 ? "$\(vehicle.price.formatted())" : "Stolen Only")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.viceGreen)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.slateGray)
                .font(.caption)
        }
        .padding(10)
        .background(Color.darkCard)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.cardBorder, lineWidth: 1))
    }
}

struct VehicleDetailSheet: View {
    let vehicle: Vehicle
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    RemoteImageView(urlString: vehicle.imageUrl, fallbackSystemName: "car.fill")
                        .frame(height: 200)
                        .cornerRadius(12)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(vehicle.manufacturer.uppercased())
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.viceCyan)
                        Text(vehicle.name)
                            .font(.title2)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                        Text(vehicle.description)
                            .font(.caption)
                            .foregroundColor(.slateGray)
                            .lineSpacing(3)
                    }
                    
                    CustomCard {
                        VStack(spacing: 12) {
                            statRow(name: "Top Speed", value: "\(Int(vehicle.topSpeedMph)) MPH", percent: vehicle.topSpeedMph / 250.0)
                            statRow(name: "Acceleration", value: "\(Int(vehicle.acceleration * 100))%", percent: vehicle.acceleration)
                            statRow(name: "Braking", value: "\(Int(vehicle.braking * 100))%", percent: vehicle.braking)
                            statRow(name: "Handling", value: "\(Int(vehicle.handling * 100))%", percent: vehicle.handling)
                            statRow(name: "Armor", value: "\(Int(vehicle.armor * 100))%", percent: vehicle.armor)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("SPAWN LOCATIONS")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.viceGold)
                        ForEach(vehicle.spawnLocations, id: \.self) { loc in
                            HStack {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(.viceGold)
                                Text(loc)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color.viceBackground.ignoresSafeArea())
            .navigationTitle(vehicle.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { presentationMode.wrappedValue.dismiss() }
                        .foregroundColor(.neonPink)
                }
            }
        }
    }
    
    private func statRow(name: String, value: String, percent: Double) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(name)
                    .font(.caption2)
                    .foregroundColor(.white)
                Spacer()
                Text(value)
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.viceCyan)
            }
            ProgressBar(progress: percent, height: 6)
        }
    }
}
