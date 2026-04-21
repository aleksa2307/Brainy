import UIKit
import SnapKit

final class LoginView: UIView, UITextFieldDelegate {

    var onBack: (() -> Void)?
    var onLogin: (() -> Void)?
    var onForgotPassword: (() -> Void)?
    var onSignUp: (() -> Void)?

    let backButton = UIButton(type: .system)

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    private let emailLabel = UILabel()
    private let emailContainer = UIView()
    private let emailIcon = UIImageView()
    let emailField = UITextField()

    private let passwordLabel = UILabel()
    private let passwordContainer = UIView()
    private let passwordIcon = UIImageView()
    let passwordField = UITextField()
    private let eyeButton = UIButton(type: .system)

    private let forgotButton = UIButton(type: .system)

    private let loginButton = UIButton()
    private let loginGradient = CAGradientLayer()

    private let noAccountLabel = UILabel()
    private let signUpButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        loginGradient.frame = loginButton.bounds
    }
}

private extension LoginView {

    func setupUI() {
        backgroundColor = UIColor(hex: "f8fafc")

        setupBackButton()
        setupTitleArea()
        setupEmailField()
        setupPasswordField()
        setupForgotButton()
        setupLoginButton()
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
        titleLabel.text = "Welcome back! 👋"
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = UIColor(hex: "0f172a")

        subtitleLabel.text = "Sign in to continue your journey"
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.textColor = UIColor(hex: "64748b")
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
        emailField.returnKeyType = .next
        emailField.delegate = self
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
        passwordField.returnKeyType = .done
        passwordField.delegate = self
        passwordField.attributedPlaceholder = NSAttributedString(
            string: "Enter your password",
            attributes: [.foregroundColor: UIColor(hex: "0f172a").withAlphaComponent(0.5)]
        )

        eyeButton.setImage(UIImage(systemName: "eye")?.withRenderingMode(.alwaysTemplate), for: .normal)
        eyeButton.imageView?.contentMode = .scaleAspectFit
        eyeButton.tintColor = UIColor(hex: "94a3b8")
        eyeButton.addTarget(self, action: #selector(eyeTapped), for: .touchUpInside)
    }

    func setupForgotButton() {
        forgotButton.setTitle("Forgot password?", for: .normal)
        forgotButton.setTitleColor(UIColor(hex: "4f46e5"), for: .normal)
        forgotButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        forgotButton.addTarget(self, action: #selector(forgotTapped), for: .touchUpInside)
    }

    func setupLoginButton() {
        loginGradient.colors = [
            UIColor(hex: "4f46e5").cgColor,
            UIColor(hex: "7c3aed").cgColor
        ]
        loginGradient.startPoint = CGPoint(x: 0, y: 0)
        loginGradient.endPoint = CGPoint(x: 1, y: 1)
        loginGradient.cornerRadius = 18
        loginButton.layer.insertSublayer(loginGradient, at: 0)

        loginButton.layer.cornerRadius = 18
        loginButton.clipsToBounds = true
        loginButton.layer.shadowColor = UIColor(hex: "4f46e5").cgColor
        loginButton.layer.shadowOpacity = 0.35
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        loginButton.layer.shadowRadius = 12
        loginButton.layer.masksToBounds = false

        loginButton.setAttributedTitle(
            NSAttributedString(
                string: "Log In",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 17, weight: .bold),
                    .foregroundColor: UIColor.white
                ]
            ),
            for: .normal
        )
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }

    func setupBottomArea() {
        noAccountLabel.text = "Don't have an account? "
        noAccountLabel.font = .systemFont(ofSize: 15)
        noAccountLabel.textColor = UIColor(hex: "64748b")

        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(UIColor(hex: "4f46e5"), for: .normal)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }

    func setupConstraints() {
        [backButton, titleLabel, subtitleLabel,
         emailLabel, emailContainer,
         passwordLabel, passwordContainer,
         forgotButton, loginButton,
         noAccountLabel, signUpButton].forEach { addSubview($0) }

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

        emailLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(32)
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

        forgotButton.snp.makeConstraints {
            $0.top.equalTo(passwordContainer.snp.bottom).offset(12)
            $0.trailing.equalToSuperview().inset(24)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(forgotButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }

        noAccountLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(28)
            $0.centerX.equalToSuperview().offset(-28)
        }

        signUpButton.snp.makeConstraints {
            $0.centerY.equalTo(noAccountLabel)
            $0.leading.equalTo(noAccountLabel.snp.trailing)
        }
    }
}

private extension LoginView {

    @objc func backTapped() { onBack?() }
    @objc func loginTapped() { onLogin?() }
    @objc func forgotTapped() { onForgotPassword?() }
    @objc func signUpTapped() { onSignUp?() }


    @objc func eyeTapped() {
        passwordField.isSecureTextEntry.toggle()
        let imageName = passwordField.isSecureTextEntry ? "eye" : "eye.slash"
        eyeButton.setImage(UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
}

extension LoginView {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === emailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
