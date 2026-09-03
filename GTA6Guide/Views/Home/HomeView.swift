import SwiftUI
import Combine

struct HomeView: View {
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    let releaseDate = Calendar.current.date(from: DateComponents(year: 2026, month: 11, day: 19)) ?? Date()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    // Release Countdown Hub
                    countdownSection
                        .padding(.horizontal)
                        .padding(.top)
                    
                    // Daily Trivia Challenge Teaser
                    dailyTriviaTeaser
                        .padding(.horizontal)
                    
                    // Latest News Carousel
                    newsSection
                    
                    // Daily Pro Tip
                    dailyTipSection
                        .padding(.horizontal)
                    
                    // Overall Progress Tracker
                    quickStatsSection
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                .padding(.bottom, 20)
            }
            .background(Color.viceBackground.ignoresSafeArea())
            .navigationTitle("Vice City Hub")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Game Guides VI")
                        .font(.headline)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .tracking(2)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: MoreView()) {
                        Image(systemName: "ellipsis.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Countdown Section
    
    private var countdownSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("LAUNCH COUNTDOWN")
                    .font(.system(size: 9, weight: .bold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.neonPink.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                
                Spacer()
                
                Text("Rockstar Games")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Text("Target Release Window")
                .font(.title2)
                .fontWeight(.black)
                .foregroundColor(.white)
            
            Text("Verified: Fall 2026 • Leonida State")
                .font(.caption)
                .foregroundColor(.slateGray)
            
            CountdownTimerView(targetDate: releaseDate)
        }
        .padding()
        .background(
            ZStack {
                Image("banner")
                    .resizable()
                    .scaledToFill()
                Color.black.opacity(0.65)
            }
        )
        .cornerRadius(18)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(LinearGradient(colors: [.neonPink, .viceCyan], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
        )
    }
    
    // MARK: - Daily Trivia
    
    private var dailyTriviaTeaser: some View {
        NavigationLink(destination: TriviaQuizView()) {
            CustomCard {
                HStack(spacing: 14) {
                    Image(systemName: "brain.head.profile")
                        .font(.system(size: 30))
                        .foregroundColor(.viceGold)
                        .padding(10)
                        .background(Color.viceGold.opacity(0.15))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text("DAILY VICE CITY TRIVIA")
                            .font(.system(size: 9, weight: .black))
                            .foregroundColor(.viceGold)
                        
                        Text("Test Your Game Lore")
                            .font(.headline)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                        
                        Text("Score points, beat the clock, and set high scores.")
                            .font(.caption2)
                            .foregroundColor(.slateGray)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.slateGray)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    // MARK: - News Section
    
    private var newsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("LATEST NEWS & ANALYSIS")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.slateGray)
                .tracking(1.2)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.newsItems) { item in
                        NavigationLink(destination: NewsDetailView(item: item)) {
                            NewsCard(item: item)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.vertical, 1)
                .padding(.horizontal)
            }
        }
    }
    
    // MARK: - Daily Tip
    
    private var dailyTipSection: some View {
        CustomCard {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "lightbulb.fill")
                    .font(.title3)
                    .foregroundColor(.viceCyan)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("PRO TIP OF THE DAY")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.viceCyan)
                    
                    Text("Vehicle Respray in Police Pursuit")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Entering a Pay 'n' Spray while out of direct police line-of-sight immediately drops your wanted level to 0 stars and gives your vehicle fresh paint and new license plates.")
                        .font(.caption)
                        .foregroundColor(.slateGray)
                        .lineSpacing(2)
                }
            }
        }
    }
    
    // MARK: - Progress Stats
    
    private var quickStatsSection: some View {
        CustomCard {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("TOTAL PROGRESSION")
                        .font(.caption2)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("\(Int(viewModel.overallProgress * 100))%")
                        .font(.headline)
                        .fontWeight(.black)
                        .foregroundColor(.neonPink)
                }
                
                ProgressBar(progress: viewModel.overallProgress, height: 8)
                
                HStack {
                    Text("Leonida Guides & Map Exploration")
                        .font(.caption2)
                        .foregroundColor(.slateGray)
                    
                    Spacer()
                    
                    NavigationLink(destination: CompletionTrackerView()) {
                        Text("View 100% Checklist →")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.viceCyan)
                    }
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
        HStack(spacing: 8) {
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
        VStack(spacing: 2) {
            Text(String(format: "%02d", max(0, value)))
                .font(.system(size: 22, weight: .black, design: .monospaced))
                .foregroundColor(.white)
            Text(label)
                .font(.system(size: 9, weight: .black))
                .foregroundColor(.viceCyan)
        }
        .frame(height: 54)
        .frame(maxWidth: .infinity)
        .background(Color.darkCard.opacity(0.8))
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.cardBorder, lineWidth: 1))
    }
    
    private var days: Int { Int(max(0, timeRemaining) / 86400) }
    private var hours: Int { Int((max(0, timeRemaining).truncatingRemainder(dividingBy: 86400)) / 3600) }
    private var minutes: Int { Int((max(0, timeRemaining).truncatingRemainder(dividingBy: 3600)) / 60) }
    private var seconds: Int { Int(max(0, timeRemaining).truncatingRemainder(dividingBy: 60)) }
}

struct NewsCard: View {
    let item: NewsItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RemoteImageView(urlString: item.imageUrl, fallbackSystemName: "newspaper.fill")
                .frame(height: 90)
                .cornerRadius(8)
            
            Text(item.category.uppercased())
                .font(.system(size: 8, weight: .bold))
                .foregroundColor(.neonPink)
            
            Text(item.title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            HStack {
                Label("\(item.readTimeMinutes) min", systemImage: "clock")
                    .font(.system(size: 9))
                    .foregroundColor(.slateGray)
                Spacer()
                Text("Read →")
                    .font(.system(size: 9, weight: .bold))
                    .foregroundColor(.viceCyan)
            }
        }
        .padding(10)
        .frame(width: 210, height: 210)
        .background(Color.darkCard)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.cardBorder, lineWidth: 1))
    }
}
