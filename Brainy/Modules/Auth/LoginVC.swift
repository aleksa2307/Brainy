import UIKit

final class LoginVC: UIViewController {

    private var loginView: LoginView { view as! LoginView }

    override func loadView() {
        view = LoginView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.onBack = { [weak self] in self?.dismiss(animated: true) }
        loginView.onLogin = { [weak self] in self?.handleLogin() }
        loginView.onForgotPassword = { [weak self] in self?.handleForgotPassword() }
        loginView.onSignUp = { [weak self] in self?.showCreateAccount() }
        loginView.onApple = { [weak self] in self?.handleAppleLogin() }
        loginView.onGoogle = { [weak self] in self?.handleGoogleLogin() }

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
}

// MARK: - Private

private extension LoginVC {

    func handleLogin() {
        guard
            let email = loginView.emailField.text, !email.isEmpty,
            let password = loginView.passwordField.text, !password.isEmpty
        else {
            showAlert(message: "Please enter your email and password.")
            return
        }
        showMainApp()
    }

    func handleForgotPassword() {
        let alert = UIAlertController(title: "Reset Password", message: "Enter your email to receive a reset link.", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "your@email.com"; $0.keyboardType = .emailAddress }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Send", style: .default))
        present(alert, animated: true)
    }

    func showCreateAccount() {
        let vc = CreateAccountVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }

    func handleAppleLogin() {
        showMainApp()
    }

    func handleGoogleLogin() {
        showMainApp()
    }

    func showMainApp() {
        let tabBarVC = CustomTabBarViewController()
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.modalTransitionStyle = .crossDissolve
        present(tabBarVC, animated: true)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
