import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    private var homeView: HomeView { view as! HomeView }

    override func loadView() {
        let v = HomeView()
        v.onQuizSelected = { [weak self] item in self?.presentQuiz(item: item) }
        v.onContinueTapped = { [weak self] item in self?.presentQuiz(item: item) }
        view = v
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let user = AuthManager.shared.currentUser {
            homeView.configure(user: user, stats: StatsManager.shared.stats)
        }
    }
}

private extension HomeViewController {

    func presentQuiz(item: ExploreQuizItem) {
        let meta = QuizMeta(title: item.title, emoji: item.emoji, category: item.categoryLabel, categoryFilterID: item.categoryFilterID)
        let questions = QuizThemedQuestionProvider.questions(
            forCategory: item.categoryFilterID,
            quizTitle: item.title
        )
        let vm = QuizViewModel(questions: questions, meta: meta)
        let quizVC = QuizViewController(viewModel: vm)
        present(quizVC, animated: true)
    }
}
