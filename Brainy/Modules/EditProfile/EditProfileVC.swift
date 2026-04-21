import UIKit

final class EditProfileVC: UIViewController {

    private var editView: EditProfileView { view as! EditProfileView }

    override func loadView() {
        view = EditProfileView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        populateFields()
        editView.onBack = { [weak self] in self?.navigationController?.popViewController(animated: true) }
        editView.onSave = { [weak self] in self?.handleSave() }

        editView.nameField.addTarget(self, action: #selector(fieldsChanged), for: .editingChanged)
        editView.usernameField.addTarget(self, action: #selector(fieldsChanged), for: .editingChanged)

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
}

private extension EditProfileVC {

    func populateFields() {
        guard let user = AuthManager.shared.currentUser else { return }
        editView.nameField.text = user.name
        editView.usernameField.text = user.username
        editView.emailField.text = user.email
        updatePreview(name: user.name, username: user.username)
    }

    func updatePreview(name: String, username: String) {
        let parts = name.split(separator: " ")
        let initials: String
        if parts.count >= 2 {
            initials = String(parts[0].prefix(1) + parts[1].prefix(1)).uppercased()
        } else {
            initials = String(name.prefix(2)).uppercased()
        }
        editView.initialsLabel.text = initials
        editView.namePreviewLabel.text = name.isEmpty ? "Your Name" : name
        editView.usernamePreviewLabel.text = username.isEmpty ? "@username" : username
    }

    func handleSave() {
        let name = editView.nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        var username = editView.usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        guard !name.isEmpty else {
            showAlert(message: "Name cannot be empty.")
            return
        }

        if username.isEmpty {
            username = "@" + name.lowercased().replacingOccurrences(of: " ", with: "_")
        } else if !username.hasPrefix("@") {
            username = "@" + username
        }

        AuthManager.shared.updateUser(name: name, username: username)
        navigationController?.popViewController(animated: true)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @objc func fieldsChanged() {
        let name = editView.nameField.text ?? ""
        let username = editView.usernameField.text ?? ""
        updatePreview(name: name, username: username)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
