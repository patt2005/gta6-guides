import SwiftUI

struct TriviaQuizView: View {
    @EnvironmentObject var viewModel: GTA6ViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Score Card
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("CURRENT SCORE")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(.viceCyan)
                        Text("\(viewModel.triviaScore) PTS")
                            .font(.title2)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("HIGH SCORE")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(.viceGold)
                        Text("\(viewModel.triviaHighScore) PTS")
                            .font(.title2)
                            .fontWeight(.black)
                            .foregroundColor(.viceGold)
                    }
                }
                .padding()
                .background(Color.darkCard)
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.cardBorder, lineWidth: 1))
                .padding(.horizontal)
                .padding(.top, 10)
                
                if viewModel.isQuizFinished {
                    quizFinishedView
                } else if let question = viewModel.currentQuestion {
                    quizQuestionView(question: question)
                }
                
                Spacer(minLength: 30)
            }
        }
        .background(Color.viceBackground.ignoresSafeArea())
        .navigationTitle("Vice City Trivia")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func quizQuestionView(question: TriviaQuestion) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            // Progress Bar
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("QUESTION \(viewModel.currentTriviaIndex + 1) OF \(viewModel.triviaQuestions.count)")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.neonPink)
                    Spacer()
                }
                ProgressBar(
                    progress: Double(viewModel.currentTriviaIndex + 1) / Double(viewModel.triviaQuestions.count),
                    height: 6
                )
            }
            .padding(.horizontal)
            
            // Question Card
            CustomCard {
                VStack(alignment: .leading, spacing: 12) {
                    Text(question.question)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .lineSpacing(4)
                }
            }
            .padding(.horizontal)
            
            // Options
            VStack(spacing: 10) {
                ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in
                    Button(action: {
                        viewModel.submitTriviaAnswer(index)
                    }) {
                        HStack {
                            Text(option)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            if viewModel.isAnswerSubmitted {
                                if index == question.correctOptionIndex {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.viceGreen)
                                } else if index == viewModel.selectedAnswerIndex {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.neonPink)
                                }
                            }
                        }
                        .padding()
                        .background(optionBackgroundColor(index: index, correctIndex: question.correctOptionIndex))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(optionBorderColor(index: index, correctIndex: question.correctOptionIndex), lineWidth: 1)
                        )
                    }
                    .disabled(viewModel.isAnswerSubmitted)
                }
            }
            .padding(.horizontal)
            
            // Explanation & Next Button
            if viewModel.isAnswerSubmitted {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.viceCyan)
                        Text(question.explanation)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.9))
                            .lineSpacing(3)
                    }
                    .padding()
                    .background(Color.deepPurple.opacity(0.5))
                    .cornerRadius(10)
                    
                    Button(action: {
                        viewModel.nextTriviaQuestion()
                    }) {
                        Text(viewModel.currentTriviaIndex + 1 == viewModel.triviaQuestions.count ? "VIEW RESULTS" : "NEXT QUESTION")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.viceCyan)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var quizFinishedView: some View {
        VStack(spacing: 20) {
            Image(systemName: "trophy.fill")
                .font(.system(size: 60))
                .foregroundColor(.viceGold)
                .padding(.top, 20)
            
            Text("Quiz Completed!")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.white)
            
            Text("You scored \(viewModel.triviaScore) out of \(viewModel.triviaQuestions.count * 100) points.")
                .font(.subheadline)
                .foregroundColor(.slateGray)
            
            Button(action: {
                viewModel.resetTriviaQuiz()
            }) {
                Text("PLAY AGAIN")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.neonPink)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 40)
        }
        .padding()
    }
    
    private func optionBackgroundColor(index: Int, correctIndex: Int) -> Color {
        guard viewModel.isAnswerSubmitted else { return Color.darkCard }
        if index == correctIndex {
            return Color.viceGreen.opacity(0.2)
        } else if index == viewModel.selectedAnswerIndex {
            return Color.neonPink.opacity(0.2)
        }
        return Color.darkCard.opacity(0.6)
    }
    
    private func optionBorderColor(index: Int, correctIndex: Int) -> Color {
        guard viewModel.isAnswerSubmitted else { return Color.cardBorder }
        if index == correctIndex {
            return Color.viceGreen
        } else if index == viewModel.selectedAnswerIndex {
            return Color.neonPink
        }
        return Color.cardBorder
    }
}
