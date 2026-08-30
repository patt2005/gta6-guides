import SwiftUI
import Combine

struct HomeView: View {
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    let releaseDate = Calendar.current.date(from: DateComponents(year: 2026, month: 11, day: 19)) ?? Date()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    countdownSection
                    
                    newsSection
                    
                    quickStatsSection
                }
                .padding()
            }
            .background(Color.viceBackground.ignoresSafeArea())
        }
    }
    
    private var countdownSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("RELEASE HUB")
                    .font(.system(size: 10, weight: .bold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(12)
                Spacer()
            }
            
            Text("Countdown to launch")
                .font(.title2.bold())
            
            Text("Verified 2026-06-10 - Rockstar Games")
                .font(.caption)
                .opacity(0.8)
            
            CountdownTimerView(targetDate: releaseDate)
        }
        .padding()
        .foregroundColor(.white)
        .background(
            ZStack {
                Image("banner")
                    .resizable()
                    .scaledToFill()
                Color.black.opacity(0.6)
            }
        )
        .cornerRadius(20)
    }
    
    private var newsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("LATEST NEWS")
                .font(.headline)
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.newsItems) { item in
                        NavigationLink(destination: NewsDetailView(item: item)) {
                            NewsCard(item: item)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
    
    private var quickStatsSection: some View {
        CustomCard {
            VStack(alignment: .leading, spacing: 10) {
                Text("TOTAL COMPLETION")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                ProgressBar(progress: viewModel.overallProgress)
                
                HStack {
                    Text("\(Int(viewModel.overallProgress * 100))%")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.neonPink)
                    
                    Spacer()
                    
                    Text("Leonida State")
                        .font(.caption)
                        .foregroundColor(.slateGray)
                }
            }
        }
    }
}

struct CountdownTimerView: View {
    let targetDate: Date
    @State private var timeRemaining: TimeInterval = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack(spacing: 10) {
            timeUnit(value: days, label: "DAYS")
            timeUnit(value: hours, label: "HRS")
            timeUnit(value: minutes, label: "MIN")
            timeUnit(value: seconds, label: "SEC")
        }
        .onReceive(timer) { _ in
            timeRemaining = targetDate.timeIntervalSinceNow
        }
        .onAppear {
            timeRemaining = targetDate.timeIntervalSinceNow
        }
    }
    
    private func timeUnit(value: Int, label: String) -> some View {
        VStack {
            Text(String(format: "%02d", value))
                .font(.system(size: 24, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
            Text(label)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(height: 60)
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white.opacity(0.2), lineWidth: 1))
    }
    
    private var days: Int { Int(max(0, timeRemaining) / 86400) }
    private var hours: Int { Int((max(0, timeRemaining).truncatingRemainder(dividingBy: 86400)) / 3600) }
    private var minutes: Int { Int((max(0, timeRemaining).truncatingRemainder(dividingBy: 3600)) / 60) }
    private var seconds: Int { Int(max(0, timeRemaining).truncatingRemainder(dividingBy: 60)) }
}

struct NewsCard: View {
    let item: NewsItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(item.title)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            Text(item.summary)
                .font(.caption)
                .foregroundColor(.slateGray)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Text("READ MORE")
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(.neonPink)
        }
        .padding()
        .frame(width: 250, height: 150)
        .background(Color.deepPurple.opacity(0.5))
        .cornerRadius(12)
    }
}
