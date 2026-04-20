import UIKit
import SnapKit

final class SettingsViewController: UIViewController {

    private var settingsView: SettingsView {
        return view as! SettingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        settingsView.logOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
    }

    override func loadView() {
        view = SettingsView()
    }
}

private extension SettingsViewController {

    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc func logOutTapped() {
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive) { _ in
            // Handle logout
        })
        present(alert, animated: true)
    }
}
