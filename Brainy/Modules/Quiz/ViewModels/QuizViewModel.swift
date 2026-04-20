import Foundation

protocol QuizViewModelDelegate: AnyObject {
    func quizViewModel(_ vm: QuizViewModel, didTickTimer seconds: Int, progress: Float)
    func quizViewModel(_ vm: QuizViewModel, didReveal selectedIndex: Int, isCorrect: Bool)
    func quizViewModelDidTimeOut(_ vm: QuizViewModel)
}

final class QuizViewModel {

    let questions: [QuizQuestion]
    private(set) var currentIndex = 0
    private(set) var xp = 0
    private(set) var correctCount = 0
    private(set) var answerResults: [Bool] = []
    private(set) var timeRemaining = 30
    private(set) var totalElapsed: TimeInterval = 0

    private var timer: Timer?
    private var questionStartDate: Date?

    weak var delegate: QuizViewModelDelegate?

    var currentQuestion: QuizQuestion { questions[currentIndex] }
    var isLastQuestion: Bool { currentIndex == questions.count - 1 }
    var totalQuestions: Int { questions.count }
    var progressFraction: Float { Float(currentIndex) / Float(questions.count) }

    var accuracyPercent: Int {
        guard !questions.isEmpty else { return 0 }
        return Int(round(Float(correctCount) / Float(questions.count) * 100))
    }

    var formattedTime: String {
        let t = Int(totalElapsed)
        return String(format: "%d:%02d", t / 60, t % 60)
    }

    var motivationTitle: String {
        switch correctCount {
        case questions.count: return "Perfect Score! 🏆"
        case let n where n >= Int(Float(questions.count) * 0.7): return "Excellent Work! 🎉"
        case let n where n >= Int(Float(questions.count) * 0.4): return "Good Effort! 🌟"
        default: return "💪 Keep Practicing!"
        }
    }

    var motivationSubtitle: String {
        switch correctCount {
        case questions.count: return "You answered every question correctly!"
        case let n where n >= Int(Float(questions.count) * 0.7): return "You really know your stuff!"
        case let n where n >= Int(Float(questions.count) * 0.4): return "You're on the right track!"
        default: return "Don't give up — you're improving!"
        }
    }

    init(questions: [QuizQuestion] = QuizQuestion.sampleQuestions) {
        self.questions = questions
    }

    func startTimer() {
        timeRemaining = 30
        questionStartDate = Date()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            self.timeRemaining -= 1
            let progress = Float(max(self.timeRemaining, 0)) / 30.0
            self.delegate?.quizViewModel(self, didTickTimer: self.timeRemaining, progress: progress)
            if self.timeRemaining <= 0 {
                self.stopTimer()
                self.delegate?.quizViewModelDidTimeOut(self)
            }
        }
    }

    func selectAnswer(at index: Int) {
        stopTimer()
        let isCorrect = index == currentQuestion.correctIndex
        if isCorrect { xp += 100; correctCount += 1 }
        answerResults.append(isCorrect)
        delegate?.quizViewModel(self, didReveal: index, isCorrect: isCorrect)
    }

    func handleTimeout() {
        stopTimer()
        answerResults.append(false)
        delegate?.quizViewModel(self, didReveal: -1, isCorrect: false)
    }

    func advance() {
        guard !isLastQuestion else { return }
        currentIndex += 1
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        if let start = questionStartDate {
            totalElapsed += Date().timeIntervalSince(start)
            questionStartDate = nil
        }
    }
}
