import UIKit

final class CreateAccountVC: UIViewController {

    var hidesBackButton = false

    private var createView: CreateAccountView { view as! CreateAccountView }

    override func loadView() {
        view = CreateAccountView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createView.backButton.isHidden = hidesBackButton
        createView.onBack = { [weak self] in self?.dismiss(animated: true) }
        createView.onCreate = { [weak self] in self?.handleCreate() }
        createView.onLogIn = { [weak self] in self?.showLogin() }
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

        switch AuthManager.shared.register(name: name, email: email, password: password) {
        case .success:
            showMainApp()
        case .failure(let error):
            showAlert(message: error.message)
        }
    }

    func showLogin() {
        let vc = LoginVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
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
