import SwiftUI

struct HeistCalculatorView: View {
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    private let approaches = ["Smart / Stealth", "Aggressive Assault", "High-Tech Hacker", "Con Artist / Disguise"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header description
                VStack(alignment: .leading, spacing: 6) {
                    Text("HEIST PAYOUT & CREW CUT CALCULATOR")
                        .font(.caption2)
                        .fontWeight(.black)
                        .foregroundColor(.viceCyan)
                        .tracking(1.5)
                    
                    Text("Optimize Your Score")
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    
                    Text("Calculate net takes for Lucia and Jason after hiring crew specialists and laundering costs.")
                        .font(.caption)
                        .foregroundColor(.slateGray)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Total Take Slider Box
                CustomCard {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("TOTAL HEIST SCORE")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.viceGold)
                            
                            Spacer()
                            
                            Text(formatCurrency(viewModel.heistTake))
                                .font(.system(size: 24, weight: .black, design: .monospaced))
                                .foregroundColor(.viceGreen)
                        }
                        
                        Slider(value: $viewModel.heistTake, in: 250000...20000000, step: 50000)
                            .tint(.viceGreen)
                            .onChange(of: viewModel.heistTake) { _ in
                                Haptics.playImpact(.light)
                            }
                        
                        HStack {
                            Text("$250K")
                                .font(.caption2)
                                .foregroundColor(.slateGray)
                            Spacer()
                            Text("$10M")
                                .font(.caption2)
                                .foregroundColor(.slateGray)
                            Spacer()
                            Text("$20M")
                                .font(.caption2)
                                .foregroundColor(.slateGray)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Approach Selector
                VStack(alignment: .leading, spacing: 8) {
                    Text("TACTICAL APPROACH")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.slateGray)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(approaches, id: \.self) { approach in
                                Button(action: {
                                    viewModel.heistApproach = approach
                                    Haptics.playImpact(.light)
                                }) {
                                    Text(approach)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 8)
                                        .background(viewModel.heistApproach == approach ? Color.neonPink : Color.darkCard)
                                        .foregroundColor(viewModel.heistApproach == approach ? .black : .white)
                                        .cornerRadius(10)
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.cardBorder, lineWidth: 1))
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Crew Cut Sliders
                VStack(alignment: .leading, spacing: 14) {
                    Text("CREW PERCENTAGE SPLITS")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.slateGray)
                        .padding(.horizontal)
                    
                    CustomCard {
                        VStack(spacing: 16) {
                            CrewCutRow(name: "Lucia Caminos (Leader)", percent: $viewModel.luciaCutPercent, payout: viewModel.luciaPayout, colorHex: "FF2E63")
                            CrewCutRow(name: "Jason Duval (Leader)", percent: $viewModel.jasonCutPercent, payout: viewModel.jasonPayout, colorHex: "00F0FF")
                            CrewCutRow(name: "Hacker (Security Bypass)", percent: $viewModel.hackerCutPercent, payout: viewModel.hackerPayout, colorHex: "FFBE0B")
                            CrewCutRow(name: "Getaway Driver", percent: $viewModel.driverCutPercent, payout: viewModel.driverPayout, colorHex: "9B51E0")
                            CrewCutRow(name: "Tactical Gunman", percent: $viewModel.gunmanCutPercent, payout: viewModel.gunmanPayout, colorHex: "FF6B6B")
                            CrewCutRow(name: "Laundering / Fencing Fee", percent: $viewModel.fencingFeePercent, payout: viewModel.fencingPayout, colorHex: "8A8A9E")
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Summary Payout Breakdown
                VStack(alignment: .leading, spacing: 10) {
                    Text("ESTIMATED NET EARNINGS")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.viceCyan)
                        .padding(.horizontal)
                    
                    VStack(spacing: 10) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("LUCIA'S PROFIT")
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.neonPink)
                                Text(formatCurrency(viewModel.luciaPayout))
                                    .font(.title3)
                                    .fontWeight(.black)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("JASON'S PROFIT")
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.viceCyan)
                                Text(formatCurrency(viewModel.jasonPayout))
                                    .font(.title3)
                                    .fontWeight(.black)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        .background(Color.darkCard)
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.cardBorder, lineWidth: 1))
                        
                        HStack {
                            Text("Combined Duo Take:")
                                .font(.subheadline)
                                .foregroundColor(.slateGray)
                            Spacer()
                            Text(formatCurrency(viewModel.luciaPayout + viewModel.jasonPayout))
                                .font(.title3)
                                .fontWeight(.black)
                                .foregroundColor(.viceGreen)
                        }
                        .padding()
                        .background(Color.viceGreen.opacity(0.1))
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.viceGreen.opacity(0.3), lineWidth: 1))
                    }
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 30)
            }
        }
        .background(Color.viceBackground.ignoresSafeArea())
        .navigationTitle("Heist Calculator")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: value)) ?? "$\(Int(value))"
    }
}

struct CrewCutRow: View {
    let name: String
    @Binding var percent: Double
    let payout: Double
    let colorHex: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Circle()
                    .fill(Color(hex: colorHex))
                    .frame(width: 8, height: 8)
                
                Text(name)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("\(Int(percent))% • \(formatCurrency(payout))")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: colorHex))
            }
            
            Slider(value: $percent, in: 0...50, step: 1)
                .tint(Color(hex: colorHex))
        }
    }
    
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: value)) ?? "$\(Int(value))"
    }
}
