import UIKit

final class QuizResultsViewController: UIViewController {

    var onRetry: (() -> Void)?
    var onHome: (() -> Void)?

    private let viewModel: QuizViewModel

    init(viewModel: QuizViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
        StatsManager.shared.recordQuiz(
            title: viewModel.meta.title,
            emoji: viewModel.meta.emoji,
            category: viewModel.meta.category,
            score: viewModel.correctCount,
            total: viewModel.totalQuestions,
            xpEarned: viewModel.xp,
            timeTaken: viewModel.totalElapsed
        )
    }

    required init?(coder: NSCoder) { fatalError() }

    override func loadView() {
        let v = QuizResultsView(viewModel: viewModel)
        v.onRetry = { [weak self] in
            self?.dismiss(animated: true) { self?.onRetry?() }
        }
        v.onShare = { [weak self] in self?.shareResults() }
        v.onHome  = { [weak self] in
            self?.dismiss(animated: true) { self?.onHome?() }
        }
        view = v
    }

    private func shareResults() {
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        let image = renderer.image { _ in
            self.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
        }
        let ac = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        ac.popoverPresentationController?.sourceView = view
        present(ac, animated: true)
    }
}
