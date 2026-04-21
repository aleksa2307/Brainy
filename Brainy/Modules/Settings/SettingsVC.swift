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
        settingsView.privacyButton.addTarget(self, action: #selector(privacyTapped), for: .touchUpInside)
        settingsView.termsButton.addTarget(self, action: #selector(termsTapped), for: .touchUpInside)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    override func loadView() {
        view = SettingsView()
    }
}

extension SettingsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return (navigationController?.viewControllers.count ?? 0) > 1
    }
}

private extension SettingsViewController {

    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc func privacyTapped() {
        openURL("https://www.freeprivacypolicy.com/live/7600f2d0-5ff9-4bc9-a4e1-d8f5852fd0ab")
    }

    @objc func termsTapped() {
        openURL("https://www.freeprivacypolicy.com/live/f2a3ed55-e345-4dc8-a1c4-108fb6a4bd06")
    }

    func openURL(_ string: String) {
        guard let url = URL(string: string) else { return }
        UIApplication.shared.open(url)
    }

    func showLogin() {
        let vc = SplashVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        view.window?.rootViewController = vc
    }

    @objc func logOutTapped() {
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive) { [weak self] _ in
            AuthManager.shared.logout()
            self?.showLogin()
        })
        present(alert, animated: true)
    }
}
