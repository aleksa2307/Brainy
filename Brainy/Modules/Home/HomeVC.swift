import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    private var homeView: HomeView { view as! HomeView }

    override func loadView() {
        view = HomeView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let user = AuthManager.shared.currentUser {
            homeView.configure(user: user, stats: StatsManager.shared.stats)
        }
    }
}
