import UIKit
import SnapKit

// MARK: - Gradient helper

private final class GradientView: UIView {
    private let gradientLayer = CAGradientLayer()

    init(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0.1, y: 0.0), endPoint: CGPoint = CGPoint(x: 0.9, y: 1.0)) {
        super.init(frame: .zero)
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.insertSublayer(gradientLayer, at: 0)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

// MARK: - HomeView

final class HomeView: UIView {

    // MARK: - Scroll

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    // MARK: - Header

    private let greetingLabel = UILabel()
    private let titleLabel = UILabel()
    private let streakBadge = UIView()
    private let streakFlameLabel = UILabel()
    private let streakCountLabel = UILabel()
    private let bellButton = UIButton(type: .system)
    private let bellBadge = UIView()

    // MARK: - Continue card

    private let continueCard = GradientView(
        colors: [UIColor(hex: "4f46e5"), UIColor(hex: "7c3aed")],
        startPoint: CGPoint(x: 0.188, y: 0.109),
        endPoint: CGPoint(x: 0.812, y: 0.891)
    )
    private let continueCircle1 = UIView()
    private let continueCircle2 = UIView()
    private let continueLabelSmall = UILabel()
    private let continueTitleLabel = UILabel()
    private let progressBarBg = UIView()
    private let progressBarFill = UIView()
    private let progressLabel = UILabel()
    private let playButton = UIView()
    private let playIcon = UIImageView()

    // MARK: - Daily Challenge

    private let challengeSectionStack = UIView()
    private let challengeHeaderLabel = UILabel()
    private let challengeTimerLabel = UILabel()
    private let challengeCard = GradientView(
        colors: [UIColor(hex: "f59e0b"), UIColor(hex: "ef4444")],
        startPoint: CGPoint(x: 0.05, y: 0.0),
        endPoint: CGPoint(x: 0.95, y: 1.0)
    )
    private let challengeCircle = UIView()
    private let challengeEmojiLabel = UILabel()
    private let challengeCategoryBadge = UIView()
    private let challengeCategoryLabel = UILabel()
    private let challengeTitleLabel = UILabel()
    private let challengeSubtitleLabel = UILabel()
    private let challengeXPContainer = UIView()
    private let challengeStarIcon = UIImageView()
    private let challengeXPLabel = UILabel()

    // MARK: - Categories

    private let categoriesHeaderLabel = UILabel()
    private let categoriesScrollView = UIScrollView()
    private let categoriesStack = UIStackView()

    // MARK: - Popular

    private let popularHeaderLabel = UILabel()
    private let seeAllButton = UIButton(type: .system)
    private let popularScrollView = UIScrollView()
    private let popularStack = UIStackView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup

private extension HomeView {

    func setupUI() {
        backgroundColor = UIColor(hex: "f8fafc")
        setupScrollView()
        setupHeader()
        setupContinueCard()
        setupDailyChallenge()
        setupCategories()
        setupPopular()
    }

    func setupScrollView() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
    }

    // MARK: Header

    func setupHeader() {
        greetingLabel.text = "Good morning 🌤️"
        greetingLabel.font = .systemFont(ofSize: 14, weight: .regular)
        greetingLabel.textColor = UIColor(hex: "64748b")

        titleLabel.text = "Hi, Alex!"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = UIColor(hex: "0f172a")

        streakBadge.backgroundColor = UIColor(hex: "fef3c7")
        streakBadge.layer.cornerRadius = 12

        streakFlameLabel.text = "🔥"
        streakFlameLabel.font = .systemFont(ofSize: 14)

        streakCountLabel.text = "5"
        streakCountLabel.font = .systemFont(ofSize: 14, weight: .bold)
        streakCountLabel.textColor = UIColor(hex: "92400e")

        bellButton.backgroundColor = .white
        bellButton.layer.cornerRadius = 14
        bellButton.setImage(UIImage(systemName: "bell")?.withRenderingMode(.alwaysTemplate), for: .normal)
        bellButton.tintColor = UIColor(hex: "0f172a")

        bellBadge.backgroundColor = UIColor(hex: "ef4444")
        bellBadge.layer.cornerRadius = 4
        bellBadge.layer.borderWidth = 1.5
        bellBadge.layer.borderColor = UIColor.white.cgColor

        [streakFlameLabel, streakCountLabel].forEach { streakBadge.addSubview($0) }
        bellButton.addSubview(bellBadge)
    }

    // MARK: Continue Card

    func setupContinueCard() {
        continueCard.layer.cornerRadius = 24
        continueCard.clipsToBounds = true

        continueCircle1.backgroundColor = UIColor(white: 1, alpha: 0.1)
        continueCircle1.layer.cornerRadius = 60

        continueCircle2.backgroundColor = UIColor(white: 1, alpha: 0.07)
        continueCircle2.layer.cornerRadius = 40

        continueLabelSmall.text = "CONTINUE WHERE YOU LEFT OFF"
        continueLabelSmall.font = .systemFont(ofSize: 12, weight: .semibold)
        continueLabelSmall.textColor = UIColor(white: 1, alpha: 0.7)

        continueTitleLabel.text = "World Capitals Mastery"
        continueTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        continueTitleLabel.textColor = .white

        progressBarBg.backgroundColor = UIColor(white: 1, alpha: 0.2)
        progressBarBg.layer.cornerRadius = 3

        progressBarFill.backgroundColor = .white
        progressBarFill.layer.cornerRadius = 3

        progressLabel.text = "Question 4 of 10"
        progressLabel.font = .systemFont(ofSize: 13)
        progressLabel.textColor = UIColor(white: 1, alpha: 0.8)

        playButton.backgroundColor = UIColor(white: 1, alpha: 0.25)
        playButton.layer.cornerRadius = 14

        playIcon.image = UIImage(systemName: "play.fill")?.withRenderingMode(.alwaysTemplate)
        playIcon.tintColor = .white
        playIcon.contentMode = .scaleAspectFit

        playButton.addSubview(playIcon)
        progressBarBg.addSubview(progressBarFill)
        [continueCircle1, continueCircle2, continueLabelSmall, continueTitleLabel,
         progressBarBg, progressLabel, playButton].forEach { continueCard.addSubview($0) }
    }

    // MARK: Daily Challenge

    func setupDailyChallenge() {
        challengeHeaderLabel.text = "Daily Challenge"
        challengeHeaderLabel.font = .systemFont(ofSize: 20, weight: .bold)
        challengeHeaderLabel.textColor = UIColor(hex: "0f172a")

        challengeTimerLabel.text = "Ends in 8h 23m"
        challengeTimerLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        challengeTimerLabel.textColor = UIColor(hex: "ef4444")

        challengeCard.layer.cornerRadius = 24
        challengeCard.clipsToBounds = true

        challengeCircle.backgroundColor = UIColor(white: 1, alpha: 0.1)
        challengeCircle.layer.cornerRadius = 50

        challengeEmojiLabel.text = "🎬"
        challengeEmojiLabel.font = .systemFont(ofSize: 20)

        challengeCategoryBadge.backgroundColor = UIColor(white: 1, alpha: 0.25)
        challengeCategoryBadge.layer.cornerRadius = 8

        challengeCategoryLabel.text = "Movies"
        challengeCategoryLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        challengeCategoryLabel.textColor = .white

        challengeTitleLabel.text = "Cinema Classics"
        challengeTitleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        challengeTitleLabel.textColor = .white

        challengeSubtitleLabel.text = "10 questions · 7 min · Easy"
        challengeSubtitleLabel.font = .systemFont(ofSize: 13)
        challengeSubtitleLabel.textColor = UIColor(white: 1, alpha: 0.8)

        challengeStarIcon.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        challengeStarIcon.tintColor = .white
        challengeStarIcon.contentMode = .scaleAspectFit

        challengeXPLabel.text = "+500 XP"
        challengeXPLabel.font = .systemFont(ofSize: 13, weight: .bold)
        challengeXPLabel.textColor = .white

        challengeCategoryBadge.addSubview(challengeCategoryLabel)
        [challengeStarIcon, challengeXPLabel].forEach { challengeXPContainer.addSubview($0) }
        [challengeCircle, challengeEmojiLabel, challengeCategoryBadge,
         challengeTitleLabel, challengeSubtitleLabel, challengeXPContainer].forEach {
            challengeCard.addSubview($0)
        }
    }

    // MARK: Categories

    func setupCategories() {
        categoriesHeaderLabel.text = "Categories"
        categoriesHeaderLabel.font = .systemFont(ofSize: 20, weight: .bold)
        categoriesHeaderLabel.textColor = UIColor(hex: "0f172a")

        categoriesScrollView.showsHorizontalScrollIndicator = false
        categoriesScrollView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)

        categoriesStack.axis = .horizontal
        categoriesStack.spacing = 8
        categoriesStack.alignment = .center

        let categories = ["All", "History", "Science", "Movies", "Music", "Geography", "Sports", "IT", "Languages"]
        categories.enumerated().forEach { index, name in
            categoriesStack.addArrangedSubview(makeCategoryChip(title: name, isSelected: index == 0))
        }

        categoriesScrollView.addSubview(categoriesStack)
    }

    func makeCategoryChip(title: String, isSelected: Bool) -> UIButton {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.title = title
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14)
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attrs in
            var updated = attrs
            updated.font = .systemFont(ofSize: 14, weight: .semibold)
            return updated
        }
        button.configuration = config
        button.layer.cornerRadius = 12

        if isSelected {
            button.backgroundColor = UIColor(hex: "4f46e5")
            button.configuration?.baseForegroundColor = .white
        } else {
            button.backgroundColor = .white
            button.configuration?.baseForegroundColor = UIColor(hex: "64748b")
            button.layer.borderWidth = 1.5
            button.layer.borderColor = UIColor(hex: "e2e8f0").cgColor
        }

        button.snp.makeConstraints { $0.height.equalTo(36) }
        return button
    }

    // MARK: Popular

    func setupPopular() {
        popularHeaderLabel.text = "Popular"
        popularHeaderLabel.font = .systemFont(ofSize: 20, weight: .bold)
        popularHeaderLabel.textColor = UIColor(hex: "0f172a")

        seeAllButton.setTitle("See all", for: .normal)
        seeAllButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        seeAllButton.setTitleColor(UIColor(hex: "4f46e5"), for: .normal)

        popularScrollView.showsHorizontalScrollIndicator = false
        popularScrollView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)

        popularStack.axis = .horizontal
        popularStack.spacing = 16
        popularStack.alignment = .top

        popularStack.addArrangedSubview(makePopularCard(
            colors: [UIColor(hex: "06b6d4"), UIColor(hex: "3b82f6")],
            emoji: "🌍",
            category: "Geography",
            difficulty: "Medium",
            title: "World Capitals Mastery",
            rating: "4.8",
            time: "8 min",
            questions: "10 Q"
        ))
        popularStack.addArrangedSubview(makePopularCard(
            colors: [UIColor(hex: "8b5cf6"), UIColor(hex: "6d28d9")],
            emoji: "🎬",
            category: "Movies",
            difficulty: "Easy",
            title: "Cinema Legends",
            rating: "4.6",
            time: "6 min",
            questions: "8 Q"
        ))

        popularScrollView.addSubview(popularStack)
    }

    func makePopularCard(colors: [UIColor], emoji: String, category: String, difficulty: String, title: String, rating: String, time: String, questions: String) -> UIView {
        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 24

        let imageArea = GradientView(colors: colors)
        imageArea.layer.cornerRadius = 24
        imageArea.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageArea.clipsToBounds = true

        let emojiLabel = UILabel()
        emojiLabel.text = emoji
        emojiLabel.font = .systemFont(ofSize: 46)

        let categoryBadge = makeCardBadge(title: category)
        let diffBadge = makeCardBadge(title: difficulty)

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = UIColor(hex: "0f172a")
        titleLabel.numberOfLines = 2

        let metaStack = UIStackView()
        metaStack.axis = .horizontal
        metaStack.spacing = 8
        metaStack.alignment = .center

        metaStack.addArrangedSubview(makeMetaItem(icon: "star.fill", text: rating))
        metaStack.addArrangedSubview(makeMetaItem(icon: "clock", text: time))
        metaStack.addArrangedSubview(makeMetaItem(icon: "questionmark.circle", text: questions))

        imageArea.addSubview(emojiLabel)
        imageArea.addSubview(categoryBadge)
        imageArea.addSubview(diffBadge)
        card.addSubview(imageArea)
        card.addSubview(titleLabel)
        card.addSubview(metaStack)

        card.snp.makeConstraints { $0.width.equalTo(200) }

        imageArea.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }

        emojiLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.top.equalToSuperview().inset(12)
        }

        categoryBadge.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.bottom.equalToSuperview().inset(12)
            $0.height.equalTo(22)
        }

        diffBadge.snp.makeConstraints {
            $0.leading.equalTo(categoryBadge.snp.trailing).offset(6)
            $0.bottom.equalToSuperview().inset(12)
            $0.height.equalTo(22)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageArea.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(14)
        }

        metaStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(14)
            $0.trailing.lessThanOrEqualToSuperview().inset(14)
            $0.bottom.equalToSuperview().inset(12)
        }

        return card
    }

    func makeCardBadge(title: String) -> UIView {
        let badge = UIView()
        badge.backgroundColor = UIColor(white: 1, alpha: 0.25)
        badge.layer.cornerRadius = 8

        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        label.textColor = .white
        badge.addSubview(label)

        label.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(3)
        }

        return badge
    }

    func makeMetaItem(icon: String, text: String) -> UIView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center

        let iconView = UIImageView(image: UIImage(systemName: icon)?.withRenderingMode(.alwaysTemplate))
        iconView.tintColor = UIColor(hex: "64748b")
        iconView.contentMode = .scaleAspectFit
        iconView.snp.makeConstraints { $0.size.equalTo(12) }

        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(hex: "64748b")

        stack.addArrangedSubview(iconView)
        stack.addArrangedSubview(label)
        return stack
    }

    // MARK: Constraints

    func setupConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        [greetingLabel, titleLabel, streakBadge, bellButton,
         continueCard,
         challengeHeaderLabel, challengeTimerLabel, challengeCard,
         categoriesHeaderLabel, categoriesScrollView,
         popularHeaderLabel, seeAllButton, popularScrollView].forEach {
            contentView.addSubview($0)
        }

        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }

        // Header
        greetingLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalToSuperview().inset(24)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(greetingLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(24)
        }

        bellButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalTo(titleLabel)
            $0.size.equalTo(42)
        }

        bellBadge.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.size.equalTo(8)
        }

        streakBadge.snp.makeConstraints {
            $0.trailing.equalTo(bellButton.snp.leading).offset(-8)
            $0.centerY.equalTo(bellButton)
            $0.height.equalTo(33)
        }

        streakFlameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }

        streakCountLabel.snp.makeConstraints {
            $0.leading.equalTo(streakFlameLabel.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }

        // Continue Card
        continueCard.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(148)
        }

        continueCircle1.snp.makeConstraints {
            $0.size.equalTo(120)
            $0.trailing.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(-20)
        }

        continueCircle2.snp.makeConstraints {
            $0.size.equalTo(80)
            $0.trailing.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(-8)
        }

        continueLabelSmall.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
        }

        continueTitleLabel.snp.makeConstraints {
            $0.top.equalTo(continueLabelSmall.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(playButton.snp.leading).offset(-8)
        }

        progressBarBg.snp.makeConstraints {
            $0.top.equalTo(continueTitleLabel.snp.bottom).offset(18)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(160)
            $0.height.equalTo(6)
        }

        progressBarFill.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.4)
        }

        progressLabel.snp.makeConstraints {
            $0.top.equalTo(progressBarBg.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(20)
        }

        playButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.size.equalTo(44)
        }

        playIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(18)
        }

        // Daily Challenge
        challengeHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(continueCard.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(24)
        }

        challengeTimerLabel.snp.makeConstraints {
            $0.centerY.equalTo(challengeHeaderLabel)
            $0.trailing.equalToSuperview().inset(24)
        }

        challengeCard.snp.makeConstraints {
            $0.top.equalTo(challengeHeaderLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(128)
        }

        challengeCircle.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.trailing.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(-20)
        }

        challengeEmojiLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(20)
        }

        challengeCategoryBadge.snp.makeConstraints {
            $0.leading.equalTo(challengeEmojiLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(challengeEmojiLabel)
            $0.height.equalTo(22)
        }

        challengeCategoryLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(3)
        }

        challengeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(challengeEmojiLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
        }

        challengeSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(challengeTitleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(20)
        }

        challengeXPContainer.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(56)
        }

        challengeStarIcon.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.size.equalTo(20)
        }

        challengeXPLabel.snp.makeConstraints {
            $0.top.equalTo(challengeStarIcon.snp.bottom).offset(4)
            $0.centerX.bottom.equalToSuperview()
        }

        // Categories
        categoriesHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(challengeCard.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(24)
        }

        categoriesScrollView.snp.makeConstraints {
            $0.top.equalTo(categoriesHeaderLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }

        categoriesStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(categoriesScrollView)
        }

        // Popular
        popularHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(categoriesScrollView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(24)
        }

        seeAllButton.snp.makeConstraints {
            $0.centerY.equalTo(popularHeaderLabel)
            $0.trailing.equalToSuperview().inset(24)
        }

        popularScrollView.snp.makeConstraints {
            $0.top.equalTo(popularHeaderLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(196)
            $0.bottom.equalToSuperview().inset(24)
        }

        popularStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(popularScrollView)
        }
    }
}
