import UIKit
import SnapKit

final class RanksViewController: UIViewController {

    private var ranksView: RanksView { view as! RanksView }

    override func loadView() {
        view = RanksView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let user = AuthManager.shared.currentUser {
            ranksView.configure(user: user, stats: StatsManager.shared.stats)
        }
    }
}
