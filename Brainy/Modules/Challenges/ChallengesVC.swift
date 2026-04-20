import UIKit
import SnapKit

final class ChallengesViewController: UIViewController {

    private var challengesView: ChallengesView { view as! ChallengesView }

    override func loadView() {
        view = ChallengesView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        challengesView.configure(stats: StatsManager.shared.stats)
    }
}
