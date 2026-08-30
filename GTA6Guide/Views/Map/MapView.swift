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
                        .frame(width: 1000, height: 1000)
                    
                    // Pins
                    ForEach(viewModel.mapPins) { pin in
                        PinView(pin: pin)
                            .position(x: pin.coordinate.x * 1000, y: pin.coordinate.y * 1000)
                            .onTapGesture {
                                withAnimation {
                                    selectedPin = pin
                                }
                            }
                    }
                }
                .scaleEffect(scale)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = CGSize(width: lastOffset.width + value.translation.width,
                                          height: lastOffset.height + value.translation.height)
                        }
                        .onEnded { _ in
                            lastOffset = offset
                        }
                )
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            scale = lastScale * value
                        }
                        .onEnded { _ in
                            lastScale = scale
                        }
                )
            }
            
            // Selection Card
            if let pin = selectedPin {
                VStack {
                    Spacer()
                    PinDetailCard(pin: pin, isSelected: $selectedPin)
                        .transition(.move(edge: .bottom))
                        .padding()
                }
            }
            
            // Map Controls
            VStack {
                HStack {
                    Spacer()
                    VStack(spacing: 10) {
                        MapControlButton(systemName: "plus") { scale *= 1.2 }
                        MapControlButton(systemName: "minus") { scale /= 1.2 }
                        MapControlButton(systemName: "scope") { 
                            withAnimation {
                                scale = 1.0
                                offset = .zero
                            }
                        }
                    }
                    .padding()
                }
                Spacer()
            }
        }
        .navigationTitle("Leonida Map")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct PinView: View {
    let pin: MapPin
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: iconName)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(pin.isCompleted ? .neonPink : .neonPink)
                .padding(8)
                .background(Color.deepPurple)
                .clipShape(Circle())
                .overlay(Circle().stroke(pin.isCompleted ? Color.neonPink : Color.neonPink, lineWidth: 2))
            
            Image(systemName: "triangle.fill")
                .font(.system(size: 10))
                .foregroundColor(pin.isCompleted ? .neonPink : .neonPink)
                .rotationEffect(.degrees(180))
                .offset(y: -4)
        }
    }
    
    private var iconName: String {
        switch pin.type {
        case .safehouse: return "house.fill"
        case .weapon: return "scope"
        case .collectible: return "star.fill"
        case .activity: return "flag.fill"
        case .secret: return "questionmark.circle.fill"
        }
    }
}

struct PinDetailCard: View {
    let pin: MapPin
    @Binding var isSelected: MapPin?
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    var body: some View {
        CustomCard {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(pin.type.rawValue.uppercased())
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.neonPink)
                    
                    Text(pin.title)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Button(action: { 
                        viewModel.togglePinCompletion(for: pin)
                    }) {
                        Label(pin.isCompleted ? "Completed" : "Mark as Done", systemImage: pin.isCompleted ? "checkmark.circle.fill" : "circle")
                            .font(.caption)
                            .foregroundColor(pin.isCompleted ? .neonPink : .white)
                    }
                }
                
                Spacer()
                
                Button(action: { isSelected = nil }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.slateGray)
                        .font(.title2)
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
                .font(.title3)
                .foregroundColor(.white)
                .padding(12)
                .background(Color.deepPurple.opacity(0.8))
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.neonPink, lineWidth: 1))
        }
    }
}
