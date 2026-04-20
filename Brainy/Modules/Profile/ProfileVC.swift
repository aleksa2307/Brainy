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

    override func loadView() {
        view = ProfileView()
    }
}

private extension ProfileViewController {

    @objc func settingsTapped() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
}
