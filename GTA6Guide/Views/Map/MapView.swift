import SwiftUI

struct MapView: View {
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = CGSize(width: -200, height: -200)
    @State private var lastOffset: CGSize = .zero
    
    @State private var selectedPin: MapPin? = nil
    
    var body: some View {
        ZStack {
            Color.viceBackground.ignoresSafeArea()
            
            GeometryReader { geometry in
                ZStack {
                    // Map Image
                    Image("map")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 1200, height: 1200)
                    
                    // Filtered Map Pins
                    ForEach(viewModel.filteredMapPins) { pin in
                        PinMarkerView(pin: pin, isSelected: selectedPin?.id == pin.id)
                            .position(x: pin.coordinate.x * 1200, y: pin.coordinate.y * 1200)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedPin = pin
                                    Haptics.playImpact(.light)
                                }
                            }
                    }
                }
                .scaleEffect(scale)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = CGSize(
                                width: lastOffset.width + value.translation.width,
                                height: lastOffset.height + value.translation.height
                            )
                        }
                        .onEnded { _ in
                            lastOffset = offset
                        }
                )
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            scale = max(0.6, min(3.0, lastScale * value))
                        }
                        .onEnded { _ in
                            lastScale = scale
                        }
                )
            }
            
            // Top Filter Bar Overlay
            VStack {
                VStack(spacing: 6) {
                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.slateGray)
                            .font(.caption)
                        TextField("Search locations, stashes, shops...", text: $viewModel.pinSearchText)
                            .font(.caption)
                            .foregroundColor(.white)
                        if !viewModel.pinSearchText.isEmpty {
                            Button(action: { viewModel.pinSearchText = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.slateGray)
                                    .font(.caption)
                            }
                        }
                    }
                    .padding(8)
                    .background(Color.darkCard.opacity(0.9))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.cardBorder, lineWidth: 1))
                    .padding(.horizontal)
                    
                    // Category pills
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 6) {
                            ForEach(PinType.allCases) { type in
                                Button(action: {
                                    viewModel.selectedPinType = type
                                    Haptics.playImpact(.light)
                                }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: type.iconName)
                                            .font(.system(size: 9))
                                        Text(type.rawValue)
                                            .font(.system(size: 10, weight: .bold))
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(viewModel.selectedPinType == type ? Color(hex: type.colorHex) : Color.darkCard.opacity(0.85))
                                    .foregroundColor(viewModel.selectedPinType == type ? .black : .white)
                                    .cornerRadius(12)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 8)
                
                Spacer()
            }
            
            // Map Zoom Controls Overlay
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack(spacing: 8) {
                        MapControlButton(systemName: "plus") {
                            withAnimation { scale = min(3.0, scale * 1.25) }
                        }
                        MapControlButton(systemName: "minus") {
                            withAnimation { scale = max(0.6, scale / 1.25) }
                        }
                        MapControlButton(systemName: "scope") {
                            withAnimation {
                                scale = 1.0
                                offset = CGSize(width: -200, height: -200)
                                lastOffset = offset
                                lastScale = 1.0
                            }
                        }
                    }
                    .padding()
                }
                .padding(.bottom, selectedPin != nil ? 180 : 10)
            }
            
            // Selected Pin Bottom Card
            if let pin = selectedPin {
                VStack {
                    Spacer()
                    PinDetailCard(pin: pin, isSelected: $selectedPin)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .padding()
                }
            }
        }
        .navigationTitle("Leonida Map")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PinMarkerView: View {
    let pin: MapPin
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: pin.type.iconName)
                .font(.system(size: isSelected ? 22 : 16, weight: .bold))
                .foregroundColor(pin.isCompleted ? .black : Color(hex: pin.type.colorHex))
                .padding(isSelected ? 10 : 7)
                .background(pin.isCompleted ? Color.viceGreen : Color.darkCard)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(hex: pin.type.colorHex), lineWidth: isSelected ? 3 : 2))
                .shadow(color: Color(hex: pin.type.colorHex).opacity(0.6), radius: isSelected ? 8 : 4)
            
            Image(systemName: "triangle.fill")
                .font(.system(size: 8))
                .foregroundColor(Color(hex: pin.type.colorHex))
                .rotationEffect(.degrees(180))
                .offset(y: -3)
        }
    }
}

struct PinDetailCard: View {
    let pin: MapPin
    @Binding var isSelected: MapPin?
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    var currentPin: MapPin {
        viewModel.mapPins.first(where: { $0.id == pin.id }) ?? pin
    }
    
    var body: some View {
        CustomCard {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(currentPin.type.rawValue.uppercased())
                            .font(.system(size: 9, weight: .black))
                            .foregroundColor(Color(hex: currentPin.type.colorHex))
                        
                        Text(currentPin.title)
                            .font(.headline)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                        
                        Text(currentPin.subtitle)
                            .font(.caption2)
                            .foregroundColor(.slateGray)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation { isSelected = nil }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.slateGray)
                            .font(.title3)
                    }
                }
                
                Text(currentPin.description)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.85))
                    .lineSpacing(2)
                
                if let reward = currentPin.reward {
                    HStack(spacing: 4) {
                        Image(systemName: "gift.fill")
                            .font(.caption2)
                            .foregroundColor(.viceGold)
                        Text("Reward: \(reward)")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.viceGold)
                    }
                    .padding(.vertical, 2)
                }
                
                Divider().background(Color.cardBorder)
                
                Button(action: {
                    viewModel.togglePinCompletion(for: currentPin)
                }) {
                    HStack {
                        Image(systemName: currentPin.isCompleted ? "checkmark.circle.fill" : "circle")
                        Text(currentPin.isCompleted ? "VISITED / COMPLETED" : "MARK AS VISITED")
                    }
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(currentPin.isCompleted ? .black : .white)
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(currentPin.isCompleted ? Color.viceGreen : Color.neonPink)
                    .cornerRadius(8)
                }
            }
        }
    }
}

struct MapControlButton: View {
    let systemName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.darkCard.opacity(0.9))
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.cardBorder, lineWidth: 1))
        }
    }
}
