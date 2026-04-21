import UIKit
import SnapKit

final class CreateAccountView: UIView {

    var onBack: (() -> Void)?
    var onCreate: (() -> Void)?
    var onLogIn: (() -> Void)?

    let backButton = UIButton(type: .system)

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    private let nameLabel = UILabel()
    private let nameContainer = UIView()
    private let nameIcon = UILabel()
    let nameField = UITextField()

    private let emailLabel = UILabel()
    private let emailContainer = UIView()
    private let emailIcon = UIImageView()
    let emailField = UITextField()

    private let passwordLabel = UILabel()
    private let passwordContainer = UIView()
    private let passwordIcon = UIImageView()
    let passwordField = UITextField()
    private let eyeButton = UIButton(type: .system)

    private let createButton = UIButton()
    private let createGradient = CAGradientLayer()

    private let haveAccountLabel = UILabel()
    private let logInButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        createGradient.frame = createButton.bounds
    }
}

private extension CreateAccountView {

    func setupUI() {
        backgroundColor = UIColor(hex: "f8fafc")

        setupBackButton()
        setupTitleArea()
        setupNameField()
        setupEmailField()
        setupPasswordField()
        setupCreateButton()
        setupBottomArea()
    }

    func setupBackButton() {
        backButton.backgroundColor = .white
        backButton.layer.cornerRadius = 12
        backButton.layer.shadowColor = UIColor.black.cgColor
        backButton.layer.shadowOpacity = 0.08
        backButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        backButton.layer.shadowRadius = 4
        backButton.setImage(
            UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate),
            for: .normal
        )
        backButton.tintColor = UIColor(hex: "0f172a")
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }

    func setupTitleArea() {
        titleLabel.text = "Create account ✨"
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = UIColor(hex: "0f172a")

        subtitleLabel.text = "Join millions of quiz enthusiasts"
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.textColor = UIColor(hex: "64748b")
    }

    func setupNameField() {
        nameLabel.text = "Full Name"
        nameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        nameLabel.textColor = UIColor(hex: "0f172a")

        nameContainer.backgroundColor = .white
        nameContainer.layer.cornerRadius = 14
        nameContainer.layer.borderWidth = 1.5
        nameContainer.layer.borderColor = UIColor(hex: "e2e8f0").cgColor

        nameIcon.text = "👤"
        nameIcon.font = .systemFont(ofSize: 18)

        nameField.placeholder = "Your full name"
        nameField.font = .systemFont(ofSize: 16)
        nameField.textColor = UIColor(hex: "0f172a")
        nameField.autocapitalizationType = .words
        nameField.autocorrectionType = .no
        nameField.attributedPlaceholder = NSAttributedString(
            string: "Your full name",
            attributes: [.foregroundColor: UIColor(hex: "0f172a").withAlphaComponent(0.5)]
        )
    }

    func setupEmailField() {
        emailLabel.text = "Email"
        emailLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        emailLabel.textColor = UIColor(hex: "0f172a")

        emailContainer.backgroundColor = .white
        emailContainer.layer.cornerRadius = 14
        emailContainer.layer.borderWidth = 1.5
        emailContainer.layer.borderColor = UIColor(hex: "e2e8f0").cgColor

        emailIcon.image = UIImage(systemName: "envelope")?.withRenderingMode(.alwaysTemplate)
        emailIcon.tintColor = UIColor(hex: "94a3b8")
        emailIcon.contentMode = .scaleAspectFit

        emailField.placeholder = "your@email.com"
        emailField.font = .systemFont(ofSize: 16)
        emailField.textColor = UIColor(hex: "0f172a")
        emailField.keyboardType = .emailAddress
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.attributedPlaceholder = NSAttributedString(
            string: "your@email.com",
            attributes: [.foregroundColor: UIColor(hex: "0f172a").withAlphaComponent(0.5)]
        )
    }

    func setupPasswordField() {
        passwordLabel.text = "Password"
        passwordLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        passwordLabel.textColor = UIColor(hex: "0f172a")

        passwordContainer.backgroundColor = .white
        passwordContainer.layer.cornerRadius = 14
        passwordContainer.layer.borderWidth = 1.5
        passwordContainer.layer.borderColor = UIColor(hex: "e2e8f0").cgColor

        passwordIcon.image = UIImage(systemName: "lock")?.withRenderingMode(.alwaysTemplate)
        passwordIcon.tintColor = UIColor(hex: "94a3b8")
        passwordIcon.contentMode = .scaleAspectFit

        passwordField.placeholder = "Enter your password"
        passwordField.font = .systemFont(ofSize: 16)
        passwordField.textColor = UIColor(hex: "0f172a")
        passwordField.isSecureTextEntry = true
        passwordField.attributedPlaceholder = NSAttributedString(
            string: "Enter your password",
            attributes: [.foregroundColor: UIColor(hex: "0f172a").withAlphaComponent(0.5)]
        )

        eyeButton.setImage(UIImage(systemName: "eye")?.withRenderingMode(.alwaysTemplate), for: .normal)
        eyeButton.imageView?.contentMode = .scaleAspectFit
        eyeButton.tintColor = UIColor(hex: "94a3b8")
        eyeButton.addTarget(self, action: #selector(eyeTapped), for: .touchUpInside)
    }

    func setupCreateButton() {
        createGradient.colors = [
            UIColor(hex: "4f46e5").cgColor,
            UIColor(hex: "7c3aed").cgColor
        ]
        createGradient.startPoint = CGPoint(x: 0, y: 0)
        createGradient.endPoint = CGPoint(x: 1, y: 1)
        createGradient.cornerRadius = 18
        createButton.layer.insertSublayer(createGradient, at: 0)

        createButton.layer.cornerRadius = 18
        createButton.clipsToBounds = true
        createButton.layer.shadowColor = UIColor(hex: "4f46e5").cgColor
        createButton.layer.shadowOpacity = 0.35
        createButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        createButton.layer.shadowRadius = 12
        createButton.layer.masksToBounds = false

        createButton.setAttributedTitle(
            NSAttributedString(
                string: "Create Account",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 17, weight: .bold),
                    .foregroundColor: UIColor.white
                ]
            ),
            for: .normal
        )
        createButton.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
    }

    func setupBottomArea() {
        haveAccountLabel.text = "Already have an account? "
        haveAccountLabel.font = .systemFont(ofSize: 15)
        haveAccountLabel.textColor = UIColor(hex: "64748b")

        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(UIColor(hex: "4f46e5"), for: .normal)
        logInButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        logInButton.addTarget(self, action: #selector(logInTapped), for: .touchUpInside)
    }

    func setupConstraints() {
        [backButton, titleLabel, subtitleLabel,
         nameLabel, nameContainer,
         emailLabel, emailContainer,
         passwordLabel, passwordContainer,
         createButton,
         haveAccountLabel, logInButton].forEach { addSubview($0) }

        [nameIcon, nameField].forEach { nameContainer.addSubview($0) }
        [emailIcon, emailField].forEach { emailContainer.addSubview($0) }
        [passwordIcon, passwordField, eyeButton].forEach { passwordContainer.addSubview($0) }

        backButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(24)
            $0.size.equalTo(40)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        nameContainer.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }

        nameIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(17)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }

        nameField.snp.makeConstraints {
            $0.leading.equalTo(nameIcon.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(17)
            $0.centerY.equalToSuperview()
        }

        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameContainer.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        emailContainer.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }

        emailIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(17)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(18)
        }

        emailField.snp.makeConstraints {
            $0.leading.equalTo(emailIcon.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(17)
            $0.centerY.equalToSuperview()
        }

        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailContainer.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        passwordContainer.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }

        passwordIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(17)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(18)
        }

        eyeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(17)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(22)
        }

        passwordField.snp.makeConstraints {
            $0.leading.equalTo(passwordIcon.snp.trailing).offset(12)
            $0.trailing.equalTo(eyeButton.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
        }

        createButton.snp.makeConstraints {
            $0.top.equalTo(passwordContainer.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }

        haveAccountLabel.snp.makeConstraints {
            $0.top.equalTo(createButton.snp.bottom).offset(28)
            $0.centerX.equalToSuperview().offset(-22)
        }

        logInButton.snp.makeConstraints {
            $0.centerY.equalTo(haveAccountLabel)
            $0.leading.equalTo(haveAccountLabel.snp.trailing)
        }
    }
}

private extension CreateAccountView {

    @objc func backTapped() { onBack?() }
    @objc func createTapped() { onCreate?() }
    @objc func logInTapped() { onLogIn?() }

    @objc func eyeTapped() {
        passwordField.isSecureTextEntry.toggle()
        let imageName = passwordField.isSecureTextEntry ? "eye" : "eye.slash"
        eyeButton.setImage(UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
}
