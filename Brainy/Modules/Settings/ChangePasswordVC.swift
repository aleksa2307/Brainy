import UIKit

final class ChangePasswordVC: UIViewController {

    private let mockCode = "123456"
    private var changeView: ChangePasswordView { view as! ChangePasswordView }

    override func loadView() {
        view = ChangePasswordView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let email = AuthManager.shared.currentUser?.email {
            changeView.configure(email: email)
        }
        changeView.onBack = { [weak self] in self?.navigationController?.popViewController(animated: true) }
        changeView.onUpdate = { [weak self] in self?.handleUpdate() }
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        setupKeyboardAvoidance()
    }
}

private extension ChangePasswordVC {

    func handleUpdate() {
        let code = changeView.codeField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let newPass = changeView.newPassField.text ?? ""
        let confirm = changeView.confirmPassField.text ?? ""

        guard code == mockCode else {
            showAlert(title: "Wrong Code", message: "The verification code is incorrect.\n\nHint: check the yellow badge 🔑")
            shake(changeView.codeField.superview)
            return
        }
        guard newPass.count >= 6 else {
            showAlert(title: "Too Short", message: "Password must be at least 6 characters.")
            return
        }
        guard newPass == confirm else {
            showAlert(title: "Passwords Don't Match", message: "Make sure both password fields are identical.")
            shake(changeView.confirmPassField.superview)
            return
        }

        AuthManager.shared.updatePassword(newPass)
        showSuccess()
    }

    func showSuccess() {
        let alert = UIAlertController(title: "✅ Password Updated", message: "Your password has been changed successfully.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func shake(_ view: UIView?) {
        guard let v = view else { return }
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.4
        animation.values = [-8, 8, -6, 6, -4, 4, 0]
        v.layer.add(animation, forKey: "shake")
    }

    @objc func dismissKeyboard() { view.endEditing(true) }
}
