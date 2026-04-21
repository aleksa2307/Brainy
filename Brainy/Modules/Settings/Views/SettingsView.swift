import UIKit
import SnapKit

private final class SettingsItemView: UIView {

    enum Accessory {
        case chevron
        case toggle(Bool)
        case valueChevron(String)
    }

    private let iconContainer = UIView()
    private let iconLabel = UILabel()
    private let itemTitleLabel = UILabel()
    private(set) var toggleSwitch: UISwitch?

    init(emoji: String, title: String, accessory: Accessory) {
        super.init(frame: .zero)

        iconContainer.backgroundColor = UIColor(hex: "f8fafc")
        iconContainer.layer.cornerRadius = 10

        iconLabel.text = emoji
        iconLabel.font = .systemFont(ofSize: 17)
        iconLabel.textAlignment = .center

        itemTitleLabel.text = title
        itemTitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        itemTitleLabel.textColor = UIColor(hex: "0f172a")

        iconContainer.addSubview(iconLabel)
        addSubview(iconContainer)
        addSubview(itemTitleLabel)

        iconLabel.snp.makeConstraints { $0.center.equalToSuperview() }
        iconContainer.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(36)
        }
        itemTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconContainer.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview().inset(64)
        }

        setupAccessory(accessory)
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupAccessory(_ accessory: Accessory) {
        switch accessory {
        case .chevron:
            let chevron = makeChevron()
            addSubview(chevron)
            chevron.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(16)
                $0.centerY.equalToSuperview()
                $0.size.equalTo(14)
            }

        case .toggle(let isOn):
            let sw = UISwitch()
            sw.isOn = isOn
            sw.onTintColor = UIColor(hex: "4f46e5")
            addSubview(sw)
            sw.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(16)
                $0.centerY.equalToSuperview()
            }
            toggleSwitch = sw

        case .valueChevron(let value):
            let chevron = makeChevron()
            let valLabel = UILabel()
            valLabel.text = value
            valLabel.font = .systemFont(ofSize: 14)
            valLabel.textColor = UIColor(hex: "94a3b8")

            addSubview(chevron)
            addSubview(valLabel)

            chevron.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(16)
                $0.centerY.equalToSuperview()
                $0.size.equalTo(14)
            }
            valLabel.snp.makeConstraints {
                $0.trailing.equalTo(chevron.snp.leading).offset(-6)
                $0.centerY.equalToSuperview()
            }
        }
    }

    private func makeChevron() -> UIImageView {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate))
        iv.tintColor = UIColor(hex: "cbd5e1")
        iv.contentMode = .scaleAspectFit
        return iv
    }
}

final class SettingsView: UIView {

    let backButton = UIButton(type: .system)
    let logOutButton = UIButton(type: .system)

    private let titleLabel = UILabel()

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let editProfileRow = SettingsItemView(emoji: "👤", title: "Edit Profile", accessory: .chevron)
    private let changePasswordRow = SettingsItemView(emoji: "🔑", title: "Change Password", accessory: .chevron)
    private let emailPrefsRow = SettingsItemView(emoji: "📧", title: "Email Preferences", accessory: .chevron)

    private let darkModeRow = SettingsItemView(emoji: "🌙", title: "Dark Mode", accessory: .toggle(false))
    private let notificationsRow = SettingsItemView(emoji: "🔔", title: "Notifications", accessory: .toggle(true))
    private let soundEffectsRow = SettingsItemView(emoji: "🔊", title: "Sound Effects", accessory: .toggle(true))
    private let hapticRow = SettingsItemView(emoji: "📳", title: "Haptic Feedback", accessory: .toggle(true))

    private let privacyRow = SettingsItemView(emoji: "🛡️", title: "Privacy Policy", accessory: .chevron)
    private let termsRow = SettingsItemView(emoji: "📄", title: "Terms of Service", accessory: .chevron)
    let editProfileButton = UIButton(type: .system)
    let changePasswordButton = UIButton(type: .system)
    let privacyButton = UIButton(type: .system)
    let termsButton = UIButton(type: .system)
    
    private let appIconLabel = UILabel()
    private let appNameLabel = UILabel()
    private let versionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
private extension SettingsView {

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

        titleLabel.text = "Settings"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = UIColor(hex: "0f172a")

        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true

        appIconLabel.text = "⚡"
        appIconLabel.font = .systemFont(ofSize: 24)
        appIconLabel.textAlignment = .center

        appNameLabel.text = "Brainy"
        appNameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        appNameLabel.textColor = UIColor(hex: "64748b")
        appNameLabel.textAlignment = .center

        versionLabel.text = "Version 1.0 · Build 1"
        versionLabel.font = .systemFont(ofSize: 12)
        versionLabel.textColor = UIColor(hex: "cbd5e1")
        versionLabel.textAlignment = .center

        var logoutConfig = UIButton.Configuration.plain()
        logoutConfig.title = "Log Out"
        logoutConfig.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")?.withRenderingMode(.alwaysTemplate)
        logoutConfig.imagePlacement = .leading
        logoutConfig.imagePadding = 8
        logoutConfig.baseForegroundColor = UIColor(hex: "ef4444")
        logoutConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { a in
            var updated = a
            updated.font = .systemFont(ofSize: 16, weight: .bold)
            return updated
        }
        logOutButton.configuration = logoutConfig
        logOutButton.backgroundColor = UIColor(hex: "fee2e2")
        logOutButton.layer.cornerRadius = 18
    }

    func setupConstraints() {
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        backButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(24)
            $0.size.equalTo(40)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(12)
            $0.centerY.equalTo(backButton)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }

        let accountCard = buildCard(rows: [editProfileRow, changePasswordRow, emailPrefsRow])
        let prefsCard = buildCard(rows: [darkModeRow, notificationsRow, soundEffectsRow, hapticRow])
        let legalCard = buildCard(rows: [privacyRow, termsRow])

        editProfileRow.addSubview(editProfileButton)
        editProfileButton.snp.makeConstraints { $0.edges.equalToSuperview() }

        changePasswordRow.addSubview(changePasswordButton)
        changePasswordButton.snp.makeConstraints { $0.edges.equalToSuperview() }

        privacyRow.addSubview(privacyButton)
        privacyButton.snp.makeConstraints { $0.edges.equalToSuperview() }

        termsRow.addSubview(termsButton)
        termsButton.snp.makeConstraints { $0.edges.equalToSuperview() }

        let accountSection = buildSection(title: "ACCOUNT", card: accountCard)
        let prefsSection = buildSection(title: "PREFERENCES", card: prefsCard)
        let legalSection = buildSection(title: "LEGAL", card: legalCard)

        [accountSection, prefsSection, legalSection,
         appIconLabel, appNameLabel, versionLabel, logOutButton].forEach {
            contentView.addSubview($0)
        }

        accountSection.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        prefsSection.snp.makeConstraints {
            $0.top.equalTo(accountSection.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        legalSection.snp.makeConstraints {
            $0.top.equalTo(prefsSection.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        appIconLabel.snp.makeConstraints {
            $0.top.equalTo(legalSection.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
        }
        appNameLabel.snp.makeConstraints {
            $0.top.equalTo(appIconLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        versionLabel.snp.makeConstraints {
            $0.top.equalTo(appNameLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        logOutButton.snp.makeConstraints {
            $0.top.equalTo(versionLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(54)
            $0.bottom.equalToSuperview().inset(24)
        }

    }

    func buildSection(title: String, card: UIView) -> UIView {
        let container = UIView()

        let label = UILabel()
        label.attributedText = NSAttributedString(
            string: title,
            attributes: [
                .font: UIFont.systemFont(ofSize: 12, weight: .bold),
                .foregroundColor: UIColor(hex: "94a3b8"),
                .kern: 0.5
            ]
        )

        container.addSubview(label)
        container.addSubview(card)

        label.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(18)
        }
        card.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        return container
    }

    func buildCard(rows: [SettingsItemView]) -> UIView {
        let shadow = UIView()
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowOpacity = 0.06
        shadow.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadow.layer.shadowRadius = 6

        let clip = UIView()
        clip.backgroundColor = .white
        clip.layer.cornerRadius = 20
        clip.clipsToBounds = true

        shadow.addSubview(clip)
        clip.snp.makeConstraints { $0.edges.equalToSuperview() }

        var prev: UIView? = nil
        for (i, row) in rows.enumerated() {
            clip.addSubview(row)
            row.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(64)
                if let p = prev {
                    $0.top.equalTo(p.snp.bottom)
                } else {
                    $0.top.equalToSuperview()
                }
                if i == rows.count - 1 {
                    $0.bottom.equalToSuperview()
                }
            }

            if i < rows.count - 1 {
                let sep = UIView()
                sep.backgroundColor = UIColor(hex: "f0f4f8")
                clip.addSubview(sep)
                sep.snp.makeConstraints {
                    $0.leading.trailing.equalToSuperview().inset(16)
                    $0.bottom.equalTo(row.snp.bottom)
                    $0.height.equalTo(1)
                }
            }

            prev = row
        }

        return shadow
    }
}

