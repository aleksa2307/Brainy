import UIKit
import SnapKit

final class ChangePasswordView: UIView {

    var onBack: (() -> Void)?
    var onUpdate: (() -> Void)?

    let backButton = UIButton(type: .system)

    // Header
    private let iconContainer = UIView()
    private let iconLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    // Code hint badge
    private let codeBadge = UIView()
    private let codeBadgeLabel = UILabel()

    // Code field
    private let codeLabel = UILabel()
    private let codeContainer = UIView()
    private let codeIcon = UIImageView()
    let codeField = UITextField()

    // New password
    private let newPassLabel = UILabel()
    private let newPassContainer = UIView()
    private let newPassIcon = UIImageView()
    let newPassField = UITextField()
    private let newEyeButton = UIButton(type: .system)

    // Confirm password
    private let confirmPassLabel = UILabel()
    private let confirmPassContainer = UIView()
    private let confirmPassIcon = UIImageView()
    let confirmPassField = UITextField()
    private let confirmEyeButton = UIButton(type: .system)

    // Button
    private let updateButton = UIButton()
    private let updateGradient = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(email: String) {
        subtitleLabel.text = "Enter the code we sent to\n\(email)"
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradient.frame = updateButton.bounds
    }
}

private extension ChangePasswordView {

    func setupUI() {
        backgroundColor = UIColor(hex: "f8fafc")

        backButton.backgroundColor = .white
        backButton.layer.cornerRadius = 12
        backButton.layer.shadowColor = UIColor.black.cgColor
        backButton.layer.shadowOpacity = 0.08
        backButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        backButton.layer.shadowRadius = 4
        backButton.setImage(UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = UIColor(hex: "0f172a")
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)

        iconContainer.backgroundColor = UIColor(hex: "eef2ff")
        iconContainer.layer.cornerRadius = 30

        iconLabel.text = "📧"
        iconLabel.font = .systemFont(ofSize: 36)
        iconLabel.textAlignment = .center

        titleLabel.text = "Check your inbox"
        titleLabel.font = .systemFont(ofSize: 26, weight: .bold)
        titleLabel.textColor = UIColor(hex: "0f172a")
        titleLabel.textAlignment = .center

        subtitleLabel.text = "Enter the code we sent to your email"
        subtitleLabel.font = .systemFont(ofSize: 15)
        subtitleLabel.textColor = UIColor(hex: "64748b")
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 2

        codeBadge.backgroundColor = UIColor(hex: "fef3c7")
        codeBadge.layer.cornerRadius = 10

        codeBadgeLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        codeBadgeLabel.textColor = UIColor(hex: "92400e")
        codeBadgeLabel.textAlignment = .center
        codeBadgeLabel.text = "🔑  Demo code: 123456"

        setupField(label: codeLabel, labelText: "Verification Code",
                   container: codeContainer, icon: codeIcon,
                   systemImage: "number", field: codeField,
                   placeholder: "6-digit code", keyboard: .numberPad)
        codeField.textAlignment = .center

        setupField(label: newPassLabel, labelText: "New Password",
                   container: newPassContainer, icon: newPassIcon,
                   systemImage: "lock", field: newPassField,
                   placeholder: "Enter new password", keyboard: .default)
        newPassField.isSecureTextEntry = true
        setupEye(newEyeButton, field: newPassField, container: newPassContainer)

        setupField(label: confirmPassLabel, labelText: "Confirm Password",
                   container: confirmPassContainer, icon: confirmPassIcon,
                   systemImage: "lock.fill", field: confirmPassField,
                   placeholder: "Repeat new password", keyboard: .default)
        confirmPassField.isSecureTextEntry = true
        setupEye(confirmEyeButton, field: confirmPassField, container: confirmPassContainer)

        updateGradient.colors = [UIColor(hex: "4f46e5").cgColor, UIColor(hex: "7c3aed").cgColor]
        updateGradient.startPoint = CGPoint(x: 0, y: 0)
        updateGradient.endPoint = CGPoint(x: 1, y: 1)
        updateGradient.cornerRadius = 18
        updateButton.layer.insertSublayer(updateGradient, at: 0)
        updateButton.layer.cornerRadius = 18
        updateButton.clipsToBounds = true
        updateButton.layer.shadowColor = UIColor(hex: "4f46e5").cgColor
        updateButton.layer.shadowOpacity = 0.35
        updateButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        updateButton.layer.shadowRadius = 12
        updateButton.layer.masksToBounds = false
        updateButton.setAttributedTitle(NSAttributedString(
            string: "Update Password",
            attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .bold), .foregroundColor: UIColor.white]
        ), for: .normal)
        updateButton.addTarget(self, action: #selector(updateTapped), for: .touchUpInside)
    }

    func setupField(label: UILabel, labelText: String,
                    container: UIView, icon: UIImageView,
                    systemImage: String, field: UITextField,
                    placeholder: String, keyboard: UIKeyboardType) {
        label.text = labelText
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor(hex: "0f172a")

        container.backgroundColor = .white
        container.layer.cornerRadius = 14
        container.layer.borderWidth = 1.5
        container.layer.borderColor = UIColor(hex: "e2e8f0").cgColor

        icon.image = UIImage(systemName: systemImage)?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = UIColor(hex: "94a3b8")
        icon.contentMode = .scaleAspectFit

        field.font = .systemFont(ofSize: 16)
        field.textColor = UIColor(hex: "0f172a")
        field.keyboardType = keyboard
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor(hex: "0f172a").withAlphaComponent(0.4)]
        )
        container.addSubview(icon)
        container.addSubview(field)
        icon.snp.makeConstraints { $0.leading.equalToSuperview().inset(17); $0.centerY.equalToSuperview(); $0.size.equalTo(18) }
        field.snp.makeConstraints { $0.leading.equalTo(icon.snp.trailing).offset(12); $0.trailing.equalToSuperview().inset(17); $0.centerY.equalToSuperview() }
    }

    func setupEye(_ btn: UIButton, field: UITextField, container: UIView) {
        btn.setImage(UIImage(systemName: "eye")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tintColor = UIColor(hex: "94a3b8")
        container.addSubview(btn)
        btn.snp.makeConstraints { $0.trailing.equalToSuperview().inset(17); $0.centerY.equalToSuperview(); $0.size.equalTo(22) }
        field.snp.remakeConstraints {
            $0.leading.equalTo(container.subviews.first!.snp.trailing).offset(12)
            $0.trailing.equalTo(btn.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
        }
        btn.addAction(UIAction { [weak field, weak btn] _ in
            field?.isSecureTextEntry.toggle()
            let name = field?.isSecureTextEntry == true ? "eye" : "eye.slash"
            btn?.setImage(UIImage(systemName: name)?.withRenderingMode(.alwaysTemplate), for: .normal)
        }, for: .touchUpInside)
    }

    func setupConstraints() {
        [backButton, iconContainer, titleLabel, subtitleLabel, codeBadge,
         codeLabel, codeContainer,
         newPassLabel, newPassContainer,
         confirmPassLabel, confirmPassContainer,
         updateButton].forEach { addSubview($0) }

        iconContainer.addSubview(iconLabel)
        codeBadge.addSubview(codeBadgeLabel)

        backButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(24)
            $0.size.equalTo(40)
        }

        iconLabel.snp.makeConstraints { $0.center.equalToSuperview() }
        iconContainer.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(72)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconContainer.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        codeBadgeLabel.snp.makeConstraints { $0.leading.trailing.equalToSuperview().inset(14); $0.top.bottom.equalToSuperview().inset(8) }
        codeBadge.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }

        codeLabel.snp.makeConstraints { $0.top.equalTo(codeBadge.snp.bottom).offset(24); $0.leading.trailing.equalToSuperview().inset(24) }
        codeContainer.snp.makeConstraints { $0.top.equalTo(codeLabel.snp.bottom).offset(8); $0.leading.trailing.equalToSuperview().inset(24); $0.height.equalTo(52) }

        newPassLabel.snp.makeConstraints { $0.top.equalTo(codeContainer.snp.bottom).offset(16); $0.leading.trailing.equalToSuperview().inset(24) }
        newPassContainer.snp.makeConstraints { $0.top.equalTo(newPassLabel.snp.bottom).offset(8); $0.leading.trailing.equalToSuperview().inset(24); $0.height.equalTo(52) }

        confirmPassLabel.snp.makeConstraints { $0.top.equalTo(newPassContainer.snp.bottom).offset(16); $0.leading.trailing.equalToSuperview().inset(24) }
        confirmPassContainer.snp.makeConstraints { $0.top.equalTo(confirmPassLabel.snp.bottom).offset(8); $0.leading.trailing.equalToSuperview().inset(24); $0.height.equalTo(52) }

        updateButton.snp.makeConstraints {
            $0.top.equalTo(confirmPassContainer.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
    }

    @objc func backTapped() { onBack?() }
    @objc func updateTapped() { onUpdate?() }
}
