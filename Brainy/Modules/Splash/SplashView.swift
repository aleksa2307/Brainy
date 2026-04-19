import UIKit
import SnapKit

final class SplashView: UIView {

    var onGetStarted: (() -> Void)?
    var onSignIn: (() -> Void)?

    // MARK: - Background

    private let gradientLayer = CAGradientLayer()
    private let blob1 = UIView()
    private let blob2 = UIView()
    private let blob3 = UIView()
    private let blob4 = UIView()

    // MARK: - Content

    private let appIconContainer = UIView()
    private let appIconLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let categoriesStack = UIStackView()
    private let statsStack = UIStackView()
    private let getStartedButton = UIButton(type: .system)
    private let signInButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

// MARK: - Setup

private extension SplashView {

    func setupUI() {
        setupGradient()
        setupBlobs()
        setupIcon()
        setupLabels()
        setupCategories()
        setupStats()
        setupButtons()
    }

    func setupGradient() {
        gradientLayer.colors = [
            UIColor(hex: "3730a3").cgColor,
            UIColor(hex: "4f46e5").cgColor,
            UIColor(hex: "7c3aed").cgColor
        ]
        gradientLayer.locations = [0.085, 0.417, 0.915]
        gradientLayer.startPoint = CGPoint(x: 0.188, y: 0.109)
        gradientLayer.endPoint = CGPoint(x: 0.812, y: 0.891)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    func setupBlobs() {
        let blobConfigs: [(UIView, CGFloat, UIColor)] = [
            (blob1, 280, UIColor(white: 1, alpha: 0.07)),
            (blob2, 220, UIColor(white: 1, alpha: 0.05)),
            (blob3, 200, UIColor(white: 1, alpha: 0.06)),
            (blob4, 260, UIColor(white: 1, alpha: 0.06))
        ]
        blobConfigs.forEach { blob, size, color in
            blob.backgroundColor = color
            blob.layer.cornerRadius = size / 2
            addSubview(blob)
        }
    }

    func setupIcon() {
        appIconContainer.backgroundColor = UIColor(white: 1, alpha: 0.2)
        appIconContainer.layer.cornerRadius = 28
        appIconContainer.layer.shadowColor = UIColor.black.cgColor
        appIconContainer.layer.shadowOffset = CGSize(width: 0, height: 8)
        appIconContainer.layer.shadowRadius = 16
        appIconContainer.layer.shadowOpacity = 0.2
        addSubview(appIconContainer)

        appIconLabel.text = "⚡"
        appIconLabel.font = .systemFont(ofSize: 52)
        appIconLabel.textAlignment = .center
        appIconContainer.addSubview(appIconLabel)
    }

    func setupLabels() {
        titleLabel.text = "QuizMaster"
        titleLabel.font = .systemFont(ofSize: 40, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        addSubview(titleLabel)

        subtitleLabel.text = "Play, answer, win"
        subtitleLabel.font = .systemFont(ofSize: 18, weight: .regular)
        subtitleLabel.textColor = UIColor(white: 1, alpha: 0.75)
        subtitleLabel.textAlignment = .center
        addSubview(subtitleLabel)
    }

    func setupCategories() {
        categoriesStack.axis = .horizontal
        categoriesStack.spacing = 16
        categoriesStack.distribution = .equalSpacing
        categoriesStack.alignment = .center
        addSubview(categoriesStack)

        let items: [(String, String, UIColor)] = [
            ("🌍", "Geography", UIColor(red: 6/255, green: 182/255, blue: 212/255, alpha: 1)),
            ("🔬", "Science",   UIColor(red: 34/255, green: 197/255, blue: 94/255, alpha: 1)),
            ("🎬", "Movies",    UIColor(red: 168/255, green: 85/255, blue: 247/255, alpha: 1)),
            ("🏛️", "History",   UIColor(red: 245/255, green: 158/255, blue: 11/255, alpha: 1))
        ]
        items.forEach { emoji, title, color in
            categoriesStack.addArrangedSubview(makeCategoryPill(emoji: emoji, title: title, color: color))
        }
    }

    func makeCategoryPill(emoji: String, title: String, color: UIColor) -> UIView {
        let container = UIView()

        let box = UIView()
        box.backgroundColor = color.withAlphaComponent(0.19)
        box.layer.cornerRadius = 18
        box.layer.borderWidth = 1
        box.layer.borderColor = color.withAlphaComponent(0.31).cgColor
        container.addSubview(box)

        let emojiLabel = UILabel()
        emojiLabel.text = emoji
        emojiLabel.font = .systemFont(ofSize: 26)
        emojiLabel.textAlignment = .center
        box.addSubview(emojiLabel)

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 10)
        titleLabel.textColor = UIColor(white: 1, alpha: 0.6)
        titleLabel.textAlignment = .center
        container.addSubview(titleLabel)

        box.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.size.equalTo(58)
        }
        emojiLabel.snp.makeConstraints { $0.edges.equalToSuperview() }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(box.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        return container
    }

    func setupStats() {
        statsStack.axis = .horizontal
        statsStack.spacing = 24
        statsStack.distribution = .equalSpacing
        statsStack.alignment = .center
        addSubview(statsStack)

        let items: [(String, String)] = [
            ("500+", "Quizzes"),
            ("2M+",  "Players"),
            ("4.9",  "Rating")
        ]
        items.forEach { value, label in
            statsStack.addArrangedSubview(makeStatColumn(value: value, label: label))
        }
    }

    func makeStatColumn(value: String, label: String) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 2
        container.alignment = .center

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 22, weight: .bold)
        valueLabel.textColor = .white

        let descLabel = UILabel()
        descLabel.text = label
        descLabel.font = .systemFont(ofSize: 12)
        descLabel.textColor = UIColor(white: 1, alpha: 0.6)

        container.addArrangedSubview(valueLabel)
        container.addArrangedSubview(descLabel)
        return container
    }

    func setupButtons() {
        getStartedButton.backgroundColor = .white
        getStartedButton.layer.cornerRadius = 18
        getStartedButton.layer.shadowColor = UIColor.black.cgColor
        getStartedButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        getStartedButton.layer.shadowRadius = 16
        getStartedButton.layer.shadowOpacity = 0.2

        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString(
            "Get Started",
            attributes: AttributeContainer([
                .font: UIFont.systemFont(ofSize: 17, weight: .bold),
                .foregroundColor: UIColor(hex: "4f46e5")
            ])
        )
        getStartedButton.configuration = config
        getStartedButton.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
        addSubview(getStartedButton)

        let signInAttr = NSMutableAttributedString(
            string: "Already have an account? ",
            attributes: [
                .font: UIFont.systemFont(ofSize: 15, weight: .medium),
                .foregroundColor: UIColor(white: 1, alpha: 0.8)
            ]
        )
        signInAttr.append(NSAttributedString(
            string: "Sign in",
            attributes: [
                .font: UIFont.systemFont(ofSize: 15, weight: .semibold),
                .foregroundColor: UIColor.white,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        ))
        signInButton.setAttributedTitle(signInAttr, for: .normal)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        addSubview(signInButton)
    }

    func setupConstraints() {
        blob1.snp.makeConstraints {
            $0.width.height.equalTo(280)
            $0.leading.equalToSuperview().offset(173)
            $0.top.equalToSuperview().offset(-60)
        }
        blob2.snp.makeConstraints {
            $0.width.height.equalTo(220)
            $0.leading.equalToSuperview().offset(-80)
            $0.top.equalToSuperview().offset(100)
        }
        blob3.snp.makeConstraints {
            $0.width.height.equalTo(200)
            $0.leading.equalToSuperview().offset(243)
            $0.top.equalToSuperview().offset(532)
        }
        blob4.snp.makeConstraints {
            $0.width.height.equalTo(260)
            $0.leading.equalToSuperview().offset(-60)
            $0.top.equalToSuperview().offset(652)
        }

        appIconContainer.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(188)
            $0.size.equalTo(100)
        }
        appIconLabel.snp.makeConstraints { $0.edges.equalToSuperview() }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(appIconContainer.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }

        categoriesStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(447)
            $0.leading.greaterThanOrEqualToSuperview().inset(24)
            $0.trailing.lessThanOrEqualToSuperview().inset(24)
        }

        statsStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(568)
        }

        getStartedButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(706)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
        signInButton.snp.makeConstraints {
            $0.top.equalTo(getStartedButton.snp.bottom).offset(17)
            $0.centerX.equalToSuperview()
        }
    }

    @objc func getStartedTapped() { onGetStarted?() }
    @objc func signInTapped() { onSignIn?() }
}
