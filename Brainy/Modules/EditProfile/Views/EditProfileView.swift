import UIKit
import SnapKit

private final class GradientView: UIView {
    private let gradientLayer = CAGradientLayer()

    init(colors: [UIColor]) {
        super.init(frame: .zero)
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.1, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.9, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

final class EditProfileView: UIView {

    var onBack: (() -> Void)?
    var onSave: (() -> Void)?

    let backButton = UIButton(type: .system)

    // Avatar
    private let avatarCard = UIView()
    private let avatarView = GradientView(colors: [UIColor(hex: "4f46e5"), UIColor(hex: "7c3aed")])
    let initialsLabel = UILabel()
    let namePreviewLabel = UILabel()
    let usernamePreviewLabel = UILabel()

    // Form
    private let formCard = UIView()

    private let nameLabel = UILabel()
    private let nameContainer = UIView()
    private let nameIcon = UIImageView()
    let nameField = UITextField()

    private let usernameLabel = UILabel()
    private let usernameContainer = UIView()
    private let usernameIcon = UIImageView()
    let usernameField = UITextField()

    private let emailLabel = UILabel()
    private let emailContainer = UIView()
    private let emailIcon = UIImageView()
    let emailField = UITextField()

    // Save
    private let saveButton = UIButton()
    private let saveGradient = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        saveGradient.frame = saveButton.bounds
    }
}

private extension EditProfileView {

    func setupUI() {
        backgroundColor = UIColor(hex: "f8fafc")
        setupBackButton()
        setupAvatarSection()
        setupForm()
        setupSaveButton()
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

    func setupAvatarSection() {
        avatarCard.backgroundColor = .white
        avatarCard.layer.cornerRadius = 24
        avatarCard.layer.shadowColor = UIColor.black.cgColor
        avatarCard.layer.shadowOpacity = 0.06
        avatarCard.layer.shadowOffset = CGSize(width: 0, height: 4)
        avatarCard.layer.shadowRadius = 10

        avatarView.layer.cornerRadius = 40
        avatarView.clipsToBounds = true

        initialsLabel.font = .systemFont(ofSize: 32, weight: .bold)
        initialsLabel.textColor = .white
        initialsLabel.textAlignment = .center

        namePreviewLabel.font = .systemFont(ofSize: 20, weight: .bold)
        namePreviewLabel.textColor = UIColor(hex: "0f172a")
        namePreviewLabel.textAlignment = .center

        usernamePreviewLabel.font = .systemFont(ofSize: 14)
        usernamePreviewLabel.textColor = UIColor(hex: "64748b")
        usernamePreviewLabel.textAlignment = .center

        avatarView.addSubview(initialsLabel)
    }

    func setupForm() {
        formCard.backgroundColor = .white
        formCard.layer.cornerRadius = 24
        formCard.layer.shadowColor = UIColor.black.cgColor
        formCard.layer.shadowOpacity = 0.06
        formCard.layer.shadowOffset = CGSize(width: 0, height: 4)
        formCard.layer.shadowRadius = 10

        setupField(
            label: nameLabel, labelText: "Full Name",
            container: nameContainer, icon: nameIcon,
            systemImage: "person", field: nameField,
            placeholder: "Your full name",
            keyboard: .default, capitalization: .words
        )

        setupField(
            label: usernameLabel, labelText: "Username",
            container: usernameContainer, icon: usernameIcon,
            systemImage: "at", field: usernameField,
            placeholder: "@username",
            keyboard: .default, capitalization: .none
        )

        setupField(
            label: emailLabel, labelText: "Email",
            container: emailContainer, icon: emailIcon,
            systemImage: "envelope", field: emailField,
            placeholder: "your@email.com",
            keyboard: .emailAddress, capitalization: .none
        )

        emailField.isEnabled = false
        emailContainer.backgroundColor = UIColor(hex: "f8fafc")
        emailField.textColor = UIColor(hex: "94a3b8")
    }

    func setupField(
        label: UILabel, labelText: String,
        container: UIView, icon: UIImageView,
        systemImage: String, field: UITextField,
        placeholder: String, keyboard: UIKeyboardType,
        capitalization: UITextAutocapitalizationType
    ) {
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
        field.autocapitalizationType = capitalization
        field.autocorrectionType = .no
        field.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor(hex: "0f172a").withAlphaComponent(0.4)]
        )
    }

    func setupSaveButton() {
        saveGradient.colors = [UIColor(hex: "4f46e5").cgColor, UIColor(hex: "7c3aed").cgColor]
        saveGradient.startPoint = CGPoint(x: 0, y: 0)
        saveGradient.endPoint = CGPoint(x: 1, y: 1)
        saveGradient.cornerRadius = 18
        saveButton.layer.insertSublayer(saveGradient, at: 0)
        saveButton.layer.cornerRadius = 18
        saveButton.clipsToBounds = true
        saveButton.layer.shadowColor = UIColor(hex: "4f46e5").cgColor
        saveButton.layer.shadowOpacity = 0.35
        saveButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        saveButton.layer.shadowRadius = 12
        saveButton.layer.masksToBounds = false
        saveButton.setAttributedTitle(
            NSAttributedString(
                string: "Save Changes",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 17, weight: .bold),
                    .foregroundColor: UIColor.white
                ]
            ),
            for: .normal
        )
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }

    func setupConstraints() {
        [backButton, avatarCard, formCard, saveButton].forEach { addSubview($0) }
        [avatarView, namePreviewLabel, usernamePreviewLabel].forEach { avatarCard.addSubview($0) }
        initialsLabel.snp.makeConstraints { $0.center.equalToSuperview() }

        let fields: [(UILabel, UIView, UIImageView, UITextField)] = [
            (nameLabel, nameContainer, nameIcon, nameField),
            (usernameLabel, usernameContainer, usernameIcon, usernameField),
            (emailLabel, emailContainer, emailIcon, emailField),
        ]
        fields.forEach { lbl, container, icon, field in
            formCard.addSubview(lbl)
            formCard.addSubview(container)
            container.addSubview(icon)
            container.addSubview(field)
            icon.snp.makeConstraints { $0.leading.equalToSuperview().inset(17); $0.centerY.equalToSuperview(); $0.size.equalTo(18) }
            field.snp.makeConstraints { $0.leading.equalTo(icon.snp.trailing).offset(12); $0.trailing.equalToSuperview().inset(17); $0.centerY.equalToSuperview() }
        }

        backButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(24)
            $0.size.equalTo(40)
        }

        avatarCard.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        avatarView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(80)
        }

        namePreviewLabel.snp.makeConstraints {
            $0.top.equalTo(avatarView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        usernamePreviewLabel.snp.makeConstraints {
            $0.top.equalTo(namePreviewLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(24)
        }

        formCard.snp.makeConstraints {
            $0.top.equalTo(avatarCard.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        var prevContainer: UIView? = nil
        for (i, (lbl, container, _, _)) in fields.enumerated() {
            lbl.snp.makeConstraints {
                if let prev = prevContainer {
                    $0.top.equalTo(prev.snp.bottom).offset(16)
                } else {
                    $0.top.equalToSuperview().inset(24)
                }
                $0.leading.trailing.equalToSuperview().inset(20)
            }
            container.snp.makeConstraints {
                $0.top.equalTo(lbl.snp.bottom).offset(8)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.height.equalTo(52)
                if i == fields.count - 1 { $0.bottom.equalToSuperview().inset(24) }
            }
            prevContainer = container
        }

        saveButton.snp.makeConstraints {
            $0.top.equalTo(formCard.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
    }

    @objc func backTapped() { onBack?() }
    @objc func saveTapped() { onSave?() }
}
