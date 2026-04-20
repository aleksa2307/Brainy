import UIKit

final class ExploreViewController: UIViewController {

    private let viewModel = ExploreViewModel()

    override func loadView() {
        let v = ExploreView(viewModel: viewModel)
        v.onQuizSelected = { [weak self] item in self?.presentQuiz(item: item) }
        view = v
    }

    private func presentQuiz(item: ExploreQuizItem) {
        let meta = QuizMeta(title: item.title, emoji: item.emoji, category: item.categoryLabel)
        let questions = QuizThemedQuestionProvider.questions(
            forCategory: item.categoryFilterID,
            quizTitle: item.title
        )
        let vm = QuizViewModel(questions: questions, meta: meta)
        let quizVC = QuizViewController(viewModel: vm)
        present(quizVC, animated: true)
    }
}
