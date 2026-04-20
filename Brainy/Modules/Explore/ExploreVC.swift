import UIKit

final class ExploreViewController: UIViewController {

    private let viewModel = ExploreViewModel()

    override func loadView() {
        let v = ExploreView(viewModel: viewModel)
        v.onQuizSelected = { [weak self] in self?.presentQuiz() }
        view = v
    }

    private func presentQuiz() {
        let quizVC = QuizViewController()
        present(quizVC, animated: true)
    }
}
