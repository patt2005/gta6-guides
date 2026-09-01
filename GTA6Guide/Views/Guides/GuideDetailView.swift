import SwiftUI

struct GuideDetailView: View {
    let guide: Guide
    @EnvironmentObject var viewModel: GTA6ViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingNotesSheet: Bool = false
    @State private var userNotesText: String = ""
    @State private var copiedConfirmation: Bool = false
    
    var currentGuide: Guide {
        viewModel.guides.first(where: { $0.id == guide.id }) ?? guide
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Hero Image Header
                ZStack(alignment: .bottomLeading) {
                    RemoteImageView(urlString: currentGuide.imageUrl, fallbackSystemName: "book.pages.fill")
                        .frame(height: 240)
                        .clipped()
                    
                    LinearGradient(
                        colors: [.clear, Color.viceBackground.opacity(0.8), Color.viceBackground],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            CategoryBadge(category: currentGuide.category.rawValue)
                            
                            // Difficulty Badge
                            Text(currentGuide.difficulty.rawValue.uppercased())
                                .font(.system(size: 10, weight: .bold))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color(hex: currentGuide.difficulty.colorHex).opacity(0.2))
                                .foregroundColor(Color(hex: currentGuide.difficulty.colorHex))
                                .cornerRadius(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color(hex: currentGuide.difficulty.colorHex), lineWidth: 1)
                                )
                            
                            Spacer()
                            
                            HStack(spacing: 12) {
                                Button(action: {
                                    viewModel.toggleGuideBookmark(for: currentGuide)
                                }) {
                                    Image(systemName: currentGuide.isBookmarked ? "bookmark.fill" : "bookmark")
                                        .font(.title3)
                                        .foregroundColor(.neonPink)
                                        .padding(8)
                                        .background(Color.darkCard.opacity(0.8))
                                        .clipShape(Circle())
                                }
                                
                                ShareLink(item: "\(currentGuide.title) - GTA 6 Guide:\n\(currentGuide.summary)") {
                                    Image(systemName: "square.and.arrow.up")
                                        .font(.title3)
                                        .foregroundColor(.viceCyan)
                                        .padding(8)
                                        .background(Color.darkCard.opacity(0.8))
                                        .clipShape(Circle())
                                }
                            }
                        }
                        
                        Text(currentGuide.title)
                            .font(.system(size: 26, weight: .black))
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                    }
                    .padding()
                }
                
                // Meta Info Strip
                HStack(spacing: 20) {
                    Label("\(currentGuide.readingTime) min read", systemImage: "clock.fill")
                        .font(.caption)
                        .foregroundColor(.slateGray)
                    
                    Label("\(currentGuide.steps.count) Steps", systemImage: "list.bullet.clipboard.fill")
                        .font(.caption)
                        .foregroundColor(.viceCyan)
                    
                    if currentGuide.isCompleted {
                        Label("Completed", systemImage: "checkmark.circle.fill")
                            .font(.caption)
                            .foregroundColor(.viceGreen)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                // Summary Box
                CustomCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("MISSION BRIEFING")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.viceCyan)
                            .tracking(1.5)
                        
                        Text(currentGuide.summary)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                            .lineSpacing(4)
                    }
                }
                .padding(.horizontal)
                
                // Rewards Section
                if !currentGuide.rewards.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("EXPECTED REWARDS & UNLOCKS")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.viceGold)
                            .tracking(1.2)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(currentGuide.rewards, id: \.self) { reward in
                                    HStack(spacing: 6) {
                                        Image(systemName: "trophy.fill")
                                            .font(.caption2)
                                            .foregroundColor(.viceGold)
                                        Text(reward)
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.darkCard)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.viceGold.opacity(0.4), lineWidth: 1)
                                    )
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Full Content
                VStack(alignment: .leading, spacing: 12) {
                    Text("OVERVIEW & STRATEGY")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.slateGray)
                        .tracking(1.2)
                    
                    Text(currentGuide.content)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
                        .lineSpacing(6)
                }
                .padding(.horizontal)
                
                // Interactive Steps Checklist
                if !currentGuide.steps.isEmpty {
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Text("INTERACTIVE WALKTHROUGH CHECKLIST")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.neonPink)
                                .tracking(1.2)
                            
                            Spacer()
                            
                            Text("\(currentGuide.completedStepsCount)/\(currentGuide.steps.count) Done")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.viceCyan)
                        }
                        
                        ProgressBar(progress: currentGuide.stepsProgress, height: 6)
                        
                        ForEach(currentGuide.steps) { step in
                            GuideStepInteractiveRow(guideId: currentGuide.id, step: step)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // User Notes & Scratchpad
                CustomCard {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "note.text")
                                .foregroundColor(.viceCyan)
                            Text("PLAYER MISSION NOTES")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                            Button(action: {
                                userNotesText = currentGuide.userNotes
                                showingNotesSheet = true
                            }) {
                                Text(currentGuide.userNotes.isEmpty ? "+ Add Note" : "Edit")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.viceCyan)
                            }
                        }
                        
                        if !currentGuide.userNotes.isEmpty {
                            Text(currentGuide.userNotes)
                                .font(.caption)
                                .foregroundColor(.slateGray)
                        } else {
                            Text("Save your loadout choices, stash locations, or personal reminders for this guide.")
                                .font(.caption2)
                                .foregroundColor(.slateGray.opacity(0.7))
                        }
                    }
                }
                .padding(.horizontal)
                
                // Tags
                if !currentGuide.tags.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(currentGuide.tags, id: \.self) { tag in
                                Text("#\(tag)")
                                    .font(.caption2)
                                    .foregroundColor(.slateGray)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color.darkCard)
                                    .cornerRadius(6)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Footer Action Button
                Button(action: {
                    viewModel.toggleGuideCompletion(for: currentGuide)
                }) {
                    HStack {
                        Image(systemName: currentGuide.isCompleted ? "arrow.counterclockwise" : "checkmark.seal.fill")
                        Text(currentGuide.isCompleted ? "MARK AS INCOMPLETE" : "MARK GUIDE COMPLETED")
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(currentGuide.isCompleted ? Color.slateGray : Color.neonPink)
                    .cornerRadius(12)
                    .shadow(color: (currentGuide.isCompleted ? Color.clear : Color.neonPink.opacity(0.4)), radius: 8)
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .background(Color.viceBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingNotesSheet) {
            GuideNotesSheet(guideId: currentGuide.id, notesText: $userNotesText, isPresented: $showingNotesSheet)
        }
    }
}

struct GuideStepInteractiveRow: View {
    let guideId: UUID
    let step: GuideStep
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    var body: some View {
        Button(action: {
            viewModel.toggleGuideStep(guideId: guideId, stepId: step.id)
        }) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: step.isCompleted ? "checkmark.square.fill" : "square")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(step.isCompleted ? .neonPink : .slateGray)
                    .padding(.top, 2)
                
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("STEP \(step.stepNumber): \(step.title)")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(step.isCompleted ? .slateGray : .white)
                            .strikethrough(step.isCompleted)
                        
                        Spacer()
                    }
                    
                    Text(step.instruction)
                        .font(.caption)
                        .foregroundColor(step.isCompleted ? .slateGray.opacity(0.7) : .white.opacity(0.8))
                        .lineSpacing(3)
                        .multilineTextAlignment(.leading)
                    
                    if let tip = step.tip {
                        HStack(alignment: .top, spacing: 6) {
                            Image(systemName: "lightbulb.fill")
                                .font(.caption2)
                                .foregroundColor(.viceGold)
                            Text("PRO TIP: \(tip)")
                                .font(.caption2)
                                .foregroundColor(.viceGold.opacity(0.9))
                        }
                        .padding(8)
                        .background(Color.viceGold.opacity(0.1))
                        .cornerRadius(6)
                        .padding(.top, 4)
                    }
                }
            }
            .padding()
            .background(Color.darkCard)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(step.isCompleted ? Color.neonPink.opacity(0.4) : Color.cardBorder, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct GuideNotesSheet: View {
    let guideId: UUID
    @Binding var notesText: String
    @Binding var isPresented: Bool
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Write personal notes, strategies, or reminders for this walkthrough:")
                    .font(.caption)
                    .foregroundColor(.slateGray)
                
                TextEditor(text: $notesText)
                    .padding(8)
                    .background(Color.darkCard)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.cardBorder, lineWidth: 1))
                
                Spacer()
            }
            .padding()
            .background(Color.viceBackground.ignoresSafeArea())
            .navigationTitle("Mission Notes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { isPresented = false }
                        .foregroundColor(.slateGray)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.saveGuideUserNotes(guideId: guideId, notes: notesText)
                        isPresented = false
                    }
                    .foregroundColor(.neonPink)
                    .fontWeight(.bold)
                }
            }
        }
    }
}
