import UIKit

final class QuizViewController: UIViewController {

    private var viewModel: QuizViewModel
    private var quizView: QuizView { view as! QuizView }

    init(viewModel: QuizViewModel = QuizViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        modalPresentationStyle = .fullScreen
    }

    required init?(coder: NSCoder) { fatalError() }

    override func loadView() {
        let v = QuizView(viewModel: viewModel)
        v.onAnswerSelected = { [weak self] index in self?.viewModel.selectAnswer(at: index) }
        v.onContinue = { [weak self] in self?.handleContinue() }
        v.onClose = { [weak self] in self?.dismiss(animated: true) }
        view = v
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.startTimer()
    }

    private func handleContinue() {
        if viewModel.isLastQuestion {
            let resultsVC = QuizResultsViewController(viewModel: viewModel)
            resultsVC.onRetry = { [weak self] in
                guard let self else { return }
                // Fresh VM, reuse same QuizVC — no dismiss/re-present needed
                let freshVM = QuizViewModel(questions: self.viewModel.questions)
                freshVM.delegate = self
                self.viewModel = freshVM
                self.quizView.reset(viewModel: freshVM)
                freshVM.startTimer()
            }
            resultsVC.onHome = { [weak self] in
                self?.dismiss(animated: true)
            }
            present(resultsVC, animated: true)
        } else {
            viewModel.advance()
            quizView.loadCurrentQuestion()
            viewModel.startTimer()
        }
    }
}

extension QuizViewController: QuizViewModelDelegate {

    func quizViewModel(_ vm: QuizViewModel, didTickTimer seconds: Int, progress: Float) {
        quizView.updateTimer(seconds: seconds, progress: progress)
    }

    func quizViewModel(_ vm: QuizViewModel, didReveal selectedIndex: Int, isCorrect: Bool) {
        quizView.revealAnswer(selectedIndex: selectedIndex, isCorrect: isCorrect)
    }

    func quizViewModelDidTimeOut(_ vm: QuizViewModel) {
        vm.handleTimeout()
    }
}
