import UIKit

final class CreateAccountVC: UIViewController {

    private var createView: CreateAccountView { view as! CreateAccountView }

    override func loadView() {
        view = CreateAccountView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createView.onBack = { [weak self] in self?.dismiss(animated: true) }
        createView.onCreate = { [weak self] in self?.handleCreate() }
        createView.onLogIn = { [weak self] in self?.dismiss(animated: true) }
        createView.onApple = { [weak self] in self?.handleAppleSignUp() }
        createView.onGoogle = { [weak self] in self?.handleGoogleSignUp() }

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
}

private extension CreateAccountVC {

    func handleCreate() {
        guard
            let name = createView.nameField.text, !name.isEmpty,
            let email = createView.emailField.text, !email.isEmpty,
            let password = createView.passwordField.text, !password.isEmpty
        else {
            showAlert(message: "Please fill in all fields.")
            return
        }
        showMainApp()
    }

    func handleAppleSignUp() {
        showMainApp()
    }

    func handleGoogleSignUp() {
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
