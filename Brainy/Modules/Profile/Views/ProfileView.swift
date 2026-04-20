import UIKit
import SnapKit

private final class GradientView: UIView {
    private let gradientLayer = CAGradientLayer()

    init(
        colors: [UIColor],
        startPoint: CGPoint = CGPoint(x: 0.1, y: 0.0),
        endPoint: CGPoint = CGPoint(x: 0.9, y: 1.0)
    ) {
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

final class ProfileView: UIView {
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let titleLabel = UILabel()
    private let bellButton = UIButton(type: .system)
    let settingsButton = UIButton(type: .system)

    private let userCard = UIView()
    private let avatarView = GradientView(colors: [UIColor(hex: "4f46e5"), UIColor(hex: "7c3aed")])
    private let initialsLabel = UILabel()
    private let levelBadgeView = UIView()
    private let levelBadgeLabel = UILabel()
    private let nameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let streakBadge = UIView()
    private let streakLabel = UILabel()
    private let xpBadge = UIView()
    private let xpLabel = UILabel()
    private let levelFromLabel = UILabel()
    private let levelToLabel = UILabel()
    private let progressBarBg = UIView()
    private let progressBarFill = GradientView(
        colors: [UIColor(hex: "4f46e5"), UIColor(hex: "7c3aed")],
        startPoint: CGPoint(x: 0, y: 0.5),
        endPoint: CGPoint(x: 1, y: 0.5)
    )
    private let xpToNextLabel = UILabel()

    private let statsTitleLabel = UILabel()
    private let statsGridView = UIView()


    private let badgesTitleLabel = UILabel()
    private let badgesCard = UIView()

    private let quizzesTitleLabel = UILabel()
    private let quizzesCard = UIView()

    private let menuCard = UIView()
    let settingsRowButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfileView {

    func setupUI() {
        backgroundColor = UIColor(hex: "f8fafc")
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        setupHeader()
        setupUserCard()
        setupStatsSection()
        setupBadgesSection()
        setupRecentQuizzesSection()
        setupMenuCard()
    }

    func setupHeader() {
        titleLabel.text = "Profile"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = UIColor(hex: "0f172a")

        [bellButton, settingsButton].forEach { btn in
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 12
            btn.layer.shadowColor = UIColor.black.cgColor
            btn.layer.shadowOpacity = 0.06
            btn.layer.shadowOffset = CGSize(width: 0, height: 2)
            btn.layer.shadowRadius = 4
            btn.tintColor = UIColor(hex: "0f172a")
        }
        bellButton.setImage(UIImage(systemName: "bell")?.withRenderingMode(.alwaysTemplate), for: .normal)
        settingsButton.setImage(UIImage(systemName: "gearshape")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }

    func setupUserCard() {
        userCard.backgroundColor = .white
        userCard.layer.cornerRadius = 24
        userCard.layer.shadowColor = UIColor.black.cgColor
        userCard.layer.shadowOpacity = 0.06
        userCard.layer.shadowOffset = CGSize(width: 0, height: 4)
        userCard.layer.shadowRadius = 10

        avatarView.layer.cornerRadius = 18
        avatarView.clipsToBounds = true

        initialsLabel.text = "AT"
        initialsLabel.font = .systemFont(ofSize: 24, weight: .bold)
        initialsLabel.textColor = .white
        initialsLabel.textAlignment = .center

        levelBadgeView.backgroundColor = UIColor(hex: "f59e0b")
        levelBadgeView.layer.cornerRadius = 13
        levelBadgeView.layer.borderWidth = 2
        levelBadgeView.layer.borderColor = UIColor.white.cgColor

        levelBadgeLabel.text = "22"
        levelBadgeLabel.font = .systemFont(ofSize: 12, weight: .heavy)
        levelBadgeLabel.textColor = .white
        levelBadgeLabel.textAlignment = .center

        nameLabel.text = "Alex Torres"
        nameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        nameLabel.textColor = UIColor(hex: "0f172a")

        usernameLabel.text = "@alex_t"
        usernameLabel.font = .systemFont(ofSize: 14)
        usernameLabel.textColor = UIColor(hex: "64748b")

        streakBadge.backgroundColor = UIColor(hex: "fef3c7")
        streakBadge.layer.cornerRadius = 8

        streakLabel.text = "🔥  5 day streak"
        streakLabel.font = .systemFont(ofSize: 13, weight: .bold)
        streakLabel.textColor = UIColor(hex: "92400e")

        xpBadge.backgroundColor = UIColor(hex: "eef2ff")
        xpBadge.layer.cornerRadius = 8

        xpLabel.text = "⚡  8,640 XP"
        xpLabel.font = .systemFont(ofSize: 13, weight: .bold)
        xpLabel.textColor = UIColor(hex: "3730a3")

        levelFromLabel.text = "Level 22"
        levelFromLabel.font = .systemFont(ofSize: 13)
        levelFromLabel.textColor = UIColor(hex: "64748b")

        levelToLabel.text = "Level 23"
        levelToLabel.font = .systemFont(ofSize: 13)
        levelToLabel.textColor = UIColor(hex: "64748b")

        progressBarBg.backgroundColor = UIColor(hex: "f1f5f9")
        progressBarBg.layer.cornerRadius = 4

        progressBarFill.layer.cornerRadius = 4
        progressBarFill.clipsToBounds = true

        xpToNextLabel.text = "1,360 XP to next level"
        xpToNextLabel.font = .systemFont(ofSize: 12)
        xpToNextLabel.textColor = UIColor(hex: "94a3b8")
        xpToNextLabel.textAlignment = .right

        levelBadgeView.addSubview(levelBadgeLabel)
        avatarView.addSubview(initialsLabel)
        progressBarBg.addSubview(progressBarFill)
        streakBadge.addSubview(streakLabel)
        xpBadge.addSubview(xpLabel)
        [avatarView, levelBadgeView, nameLabel, usernameLabel,
         streakBadge, xpBadge,
         levelFromLabel, levelToLabel, progressBarBg, xpToNextLabel].forEach {
            userCard.addSubview($0)
        }
    }

    func setupStatsSection() {
        statsTitleLabel.text = "Stats"
        statsTitleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        statsTitleLabel.textColor = UIColor(hex: "0f172a")

        let cards = [
            makeStatCard(emoji: "🎯", value: "47",       label: "Quizzes Played", valueColor: UIColor(hex: "4f46e5"), bgColor: UIColor(hex: "eef2ff")),
            makeStatCard(emoji: "🎯", value: "78%",      label: "Accuracy Rate",  valueColor: UIColor(hex: "22c55e"), bgColor: UIColor(hex: "dcfce7")),
            makeStatCard(emoji: "⭐",  value: "Science",  label: "Fav. Category",  valueColor: UIColor(hex: "f59e0b"), bgColor: UIColor(hex: "fef3c7")),
            makeStatCard(emoji: "⚡",  value: "8.3s",     label: "Avg. Answer",    valueColor: UIColor(hex: "06b6d4"), bgColor: UIColor(hex: "cffafe"))
        ]

        cards.forEach { statsGridView.addSubview($0) }

        cards[0].snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5).offset(-6)
            $0.height.equalTo(132)
        }
        cards[1].snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5).offset(-6)
            $0.height.equalTo(132)
        }
        cards[2].snp.makeConstraints {
            $0.bottom.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5).offset(-6)
            $0.height.equalTo(132)
        }
        cards[3].snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5).offset(-6)
            $0.height.equalTo(132)
        }
    }

    func makeStatCard(emoji: String, value: String, label: String, valueColor: UIColor, bgColor: UIColor) -> UIView {
        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 20
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.06
        card.layer.shadowOffset = CGSize(width: 0, height: 2)
        card.layer.shadowRadius = 6

        let iconContainer = UIView()
        iconContainer.backgroundColor = bgColor
        iconContainer.layer.cornerRadius = 12

        let emojiLabel = UILabel()
        emojiLabel.text = emoji
        emojiLabel.font = .systemFont(ofSize: 20)

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        valueLabel.textColor = valueColor

        let descLabel = UILabel()
        descLabel.text = label
        descLabel.font = .systemFont(ofSize: 12)
        descLabel.textColor = UIColor(hex: "94a3b8")

        iconContainer.addSubview(emojiLabel)
        [iconContainer, valueLabel, descLabel].forEach { card.addSubview($0) }

        emojiLabel.snp.makeConstraints { $0.center.equalToSuperview() }
        iconContainer.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.size.equalTo(40)
        }
        valueLabel.snp.makeConstraints {
            $0.top.equalTo(iconContainer.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(16)
        }
        descLabel.snp.makeConstraints {
            $0.top.equalTo(valueLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(16)
        }

        return card
    }

    func setupBadgesSection() {
        badgesTitleLabel.text = "Badges"
        badgesTitleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        badgesTitleLabel.textColor = UIColor(hex: "0f172a")

        badgesCard.backgroundColor = .white
        badgesCard.layer.cornerRadius = 20
        badgesCard.layer.shadowColor = UIColor.black.cgColor
        badgesCard.layer.shadowOpacity = 0.06
        badgesCard.layer.shadowOffset = CGSize(width: 0, height: 2)
        badgesCard.layer.shadowRadius = 6

        let row1 = makeHorizontalBadgeRow(badges: [
            makeBadgeItem(emoji: "🌍", title: "Explorer",    isLocked: false),
            makeBadgeItem(emoji: "🔬", title: "Scientist",   isLocked: false),
            makeBadgeItem(emoji: "🎬", title: "Film Buff",   isLocked: false),
            makeBadgeItem(emoji: "🎵", title: "Music Lover", isLocked: false)
        ])
        let row2 = makeHorizontalBadgeRow(badges: [
            makeBadgeItem(emoji: "⚡",  title: "Speed Runner",  isLocked: false),
            makeBadgeItem(emoji: "⭐",  title: "Perfect Score", isLocked: true),
            makeBadgeItem(emoji: "🚀",  title: "Astronaut",     isLocked: true),
            makeBadgeItem(emoji: "🗣️", title: "Polyglot",      isLocked: true)
        ])

        badgesCard.addSubview(row1)
        badgesCard.addSubview(row2)

        row1.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(80)
        }
        row2.snp.makeConstraints {
            $0.top.equalTo(row1.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(80)
            $0.bottom.equalToSuperview().inset(16)
        }
    }

    func makeHorizontalBadgeRow(badges: [UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: badges)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }

    func makeBadgeItem(emoji: String, title: String, isLocked: Bool) -> UIView {
        let container = UIView()

        let iconBg: UIView
        if isLocked {
            let bg = UIView()
            bg.backgroundColor = UIColor(hex: "f1f5f9")
            bg.alpha = 0.5
            bg.layer.cornerRadius = 14
            iconBg = bg
        } else {
            let grad = GradientView(colors: [UIColor(hex: "eef2ff"), UIColor(hex: "ddd6fe")])
            grad.layer.cornerRadius = 14
            grad.clipsToBounds = true
            iconBg = grad
        }

        let emojiLabel = UILabel()
        emojiLabel.text = emoji
        emojiLabel.font = .systemFont(ofSize: 24)
        emojiLabel.textAlignment = .center

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 10, weight: .semibold)
        titleLabel.textColor = isLocked ? UIColor(hex: "94a3b8") : UIColor(hex: "4f46e5")
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2

        iconBg.addSubview(emojiLabel)
        container.addSubview(iconBg)
        container.addSubview(titleLabel)

        emojiLabel.snp.makeConstraints { $0.center.equalToSuperview() }
        iconBg.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(52)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconBg.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        return container
    }

    func setupRecentQuizzesSection() {
        quizzesTitleLabel.text = "Recent Quizzes"
        quizzesTitleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        quizzesTitleLabel.textColor = UIColor(hex: "0f172a")

        quizzesCard.backgroundColor = .white
        quizzesCard.layer.cornerRadius = 20
        quizzesCard.layer.shadowColor = UIColor.black.cgColor
        quizzesCard.layer.shadowOpacity = 0.05
        quizzesCard.layer.shadowOffset = CGSize(width: 0, height: 2)
        quizzesCard.layer.shadowRadius = 4
        quizzesCard.clipsToBounds = false

        let rows = [
            makeQuizRow(
                emoji: "🌍",
                gradientColors: [UIColor(hex: "06b6d4"), UIColor(hex: "3b82f6")],
                title: "World Capitals", date: "2 days ago",
                score: "8/10", percent: "80%",
                scoreColor: UIColor(hex: "22c55e"), isLast: false
            ),
            makeQuizRow(
                emoji: "🎬",
                gradientColors: [UIColor(hex: "a855f7"), UIColor(hex: "6366f1")],
                title: "Cinema Classics", date: "4 days ago",
                score: "9/10", percent: "90%",
                scoreColor: UIColor(hex: "22c55e"), isLast: false
            ),
            makeQuizRow(
                emoji: "🔬",
                gradientColors: [UIColor(hex: "22c55e"), UIColor(hex: "059669")],
                title: "Science Fundamentals", date: "1 week ago",
                score: "7/10", percent: "70%",
                scoreColor: UIColor(hex: "f59e0b"), isLast: false
            ),
            makeQuizRow(
                emoji: "🎵",
                gradientColors: [UIColor(hex: "ec4899"), UIColor(hex: "f43f5e")],
                title: "Music Legends", date: "1 week ago",
                score: "7/10", percent: "70%",
                scoreColor: UIColor(hex: "f59e0b"), isLast: true
            )
        ]

        var prev: UIView? = nil
        rows.forEach { row in
            quizzesCard.addSubview(row)
            row.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(76)
                if let p = prev {
                    $0.top.equalTo(p.snp.bottom)
                } else {
                    $0.top.equalToSuperview()
                }
            }
            prev = row
        }
        if let last = rows.last {
            last.snp.makeConstraints { $0.bottom.equalToSuperview() }
        }
    }

    func makeQuizRow(emoji: String, gradientColors: [UIColor], title: String, date: String, score: String, percent: String, scoreColor: UIColor, isLast: Bool) -> UIView {
        let row = UIView()

        let iconView = GradientView(colors: gradientColors)
        iconView.layer.cornerRadius = 14
        iconView.clipsToBounds = true

        let emojiLabel = UILabel()
        emojiLabel.text = emoji
        emojiLabel.font = .systemFont(ofSize: 22)
        emojiLabel.textAlignment = .center

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        titleLabel.textColor = UIColor(hex: "0f172a")

        let dateLabel = UILabel()
        dateLabel.text = date
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = UIColor(hex: "94a3b8")

        let scoreLabel = UILabel()
        scoreLabel.text = score
        scoreLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        scoreLabel.textColor = scoreColor
        scoreLabel.textAlignment = .right

        let percentLabel = UILabel()
        percentLabel.text = percent
        percentLabel.font = .systemFont(ofSize: 11)
        percentLabel.textColor = UIColor(hex: "94a3b8")
        percentLabel.textAlignment = .right

        iconView.addSubview(emojiLabel)
        [iconView, titleLabel, dateLabel, scoreLabel, percentLabel].forEach { row.addSubview($0) }

        if !isLast {
            let sep = UIView()
            sep.backgroundColor = UIColor(hex: "f1f5f9")
            row.addSubview(sep)
            sep.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(14)
                $0.bottom.equalToSuperview()
                $0.height.equalTo(1)
            }
        }

        emojiLabel.snp.makeConstraints { $0.center.equalToSuperview() }
        iconView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(48)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconView.snp.trailing).offset(14)
            $0.bottom.equalTo(iconView.snp.centerY).offset(-1)
            $0.trailing.lessThanOrEqualTo(scoreLabel.snp.leading).offset(-8)
        }
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(iconView.snp.trailing).offset(14)
            $0.top.equalTo(iconView.snp.centerY).offset(3)
        }
        scoreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.bottom.equalTo(iconView.snp.centerY).offset(-1)
        }
        percentLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.top.equalTo(iconView.snp.centerY).offset(3)
        }

        return row
    }

    func setupMenuCard() {
        menuCard.backgroundColor = .white
        menuCard.layer.cornerRadius = 20
        menuCard.layer.shadowColor = UIColor.black.cgColor
        menuCard.layer.shadowOpacity = 0.06
        menuCard.layer.shadowOffset = CGSize(width: 0, height: 2)
        menuCard.layer.shadowRadius = 6
        menuCard.clipsToBounds = true

        let items = [
            (emoji: "🔔", title: "Notifications",  bg: UIColor(hex: "eef2ff"), isLast: false),
            (emoji: "⚙️", title: "Settings",       bg: UIColor(hex: "f1f5f9"), isLast: false),
            (emoji: "💬", title: "Help & Support", bg: UIColor(hex: "dcfce7"), isLast: true)
        ]

        var prev: UIView? = nil
        items.forEach { item in
            let row = makeMenuItem(emoji: item.emoji, iconBg: item.bg, title: item.title, isLast: item.isLast)
            menuCard.addSubview(row)
            row.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(65)
                if let p = prev {
                    $0.top.equalTo(p.snp.bottom)
                } else {
                    $0.top.equalToSuperview()
                }
            }
            if item.isLast {
                row.snp.makeConstraints { $0.bottom.equalToSuperview() }
            }
            if item.title == "Settings" {
                row.addSubview(settingsRowButton)
                settingsRowButton.snp.makeConstraints { $0.edges.equalToSuperview() }
            }
            prev = row
        }
    }

    func makeMenuItem(emoji: String, iconBg: UIColor, title: String, isLast: Bool) -> UIView {
        let row = UIView()

        let iconContainer = UIView()
        iconContainer.backgroundColor = iconBg
        iconContainer.layer.cornerRadius = 10

        let iconLabel = UILabel()
        iconLabel.text = emoji
        iconLabel.font = .systemFont(ofSize: 18)
        iconLabel.textAlignment = .center

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        titleLabel.textColor = UIColor(hex: "0f172a")

        let chevron = UIImageView(image: UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate))
        chevron.tintColor = UIColor(hex: "cbd5e1")
        chevron.contentMode = .scaleAspectFit

        iconContainer.addSubview(iconLabel)
        [iconContainer, titleLabel, chevron].forEach { row.addSubview($0) }

        if !isLast {
            let sep = UIView()
            sep.backgroundColor = UIColor(hex: "f1f5f9")
            row.addSubview(sep)
            sep.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.equalTo(1)
            }
        }

        iconLabel.snp.makeConstraints { $0.center.equalToSuperview() }
        iconContainer.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(36)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconContainer.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
        }
        chevron.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(14)
        }

        return row
    }

    func setupConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        [titleLabel, bellButton, settingsButton,
         userCard, statsTitleLabel, statsGridView,
         badgesTitleLabel, badgesCard,
         quizzesTitleLabel, quizzesCard,
         menuCard].forEach { contentView.addSubview($0) }

        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.leading.equalToSuperview().inset(24)
        }

        settingsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalTo(titleLabel)
            $0.size.equalTo(40)
        }
        bellButton.snp.makeConstraints {
            $0.trailing.equalTo(settingsButton.snp.leading).offset(-8)
            $0.centerY.equalTo(titleLabel)
            $0.size.equalTo(40)
        }

        userCard.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        avatarView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
            $0.size.equalTo(72)
        }
        initialsLabel.snp.makeConstraints { $0.center.equalToSuperview() }
        levelBadgeView.snp.makeConstraints {
            $0.size.equalTo(26)
            $0.leading.equalTo(avatarView.snp.leading).offset(50)
            $0.top.equalTo(avatarView.snp.top).offset(50)
        }
        levelBadgeView.addSubview(levelBadgeLabel)
        levelBadgeLabel.snp.makeConstraints { $0.center.equalToSuperview() }

        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(avatarView.snp.trailing).offset(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }
        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(nameLabel)
        }
        streakBadge.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(nameLabel)
            $0.height.equalTo(47)
        }
        streakLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
        xpBadge.snp.makeConstraints {
            $0.top.equalTo(streakBadge.snp.top)
            $0.leading.equalTo(streakBadge.snp.trailing).offset(8)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
            $0.height.equalTo(47)
        }
        xpLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }

        levelFromLabel.snp.makeConstraints {
            $0.top.equalTo(avatarView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
        }
        levelToLabel.snp.makeConstraints {
            $0.top.equalTo(levelFromLabel.snp.top)
            $0.trailing.equalToSuperview().inset(20)
        }
        progressBarBg.snp.makeConstraints {
            $0.top.equalTo(levelFromLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(8)
        }
        progressBarFill.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.65)
        }
        xpToNextLabel.snp.makeConstraints {
            $0.top.equalTo(progressBarBg.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }

        statsTitleLabel.snp.makeConstraints {
            $0.top.equalTo(userCard.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(24)
        }
        statsGridView.snp.makeConstraints {
            $0.top.equalTo(statsTitleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(276)
        }
        
        badgesTitleLabel.snp.makeConstraints {
            $0.top.equalTo(statsGridView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(24)
        }
        badgesCard.snp.makeConstraints {
            $0.top.equalTo(badgesTitleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        quizzesTitleLabel.snp.makeConstraints {
            $0.top.equalTo(badgesCard.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(24)
        }
        quizzesCard.snp.makeConstraints {
            $0.top.equalTo(quizzesTitleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        menuCard.snp.makeConstraints {
            $0.top.equalTo(quizzesCard.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(32)
        }
    }
}
