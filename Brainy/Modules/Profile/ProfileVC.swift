import UIKit
import SnapKit

final class ProfileViewController: UIViewController {

    private var profileView: ProfileView {
        return view as! ProfileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.settingsRowButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        profileView.settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let user = AuthManager.shared.currentUser {
            profileView.configure(user: user, stats: StatsManager.shared.stats)
        }
    }

    override func loadView() {
        view = ProfileView()
    }
}

private extension ProfileViewController {

    @objc func settingsTapped() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
}
