import UIKit
import SnapKit

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

final class HomeView: UIView {
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let greetingLabel = UILabel()
    private let titleLabel = UILabel()
    private let streakBadge = UIView()
    private let streakFlameLabel = UILabel()
    private let streakCountLabel = UILabel()
    private let bellButton = UIButton(type: .system)
    private let bellBadge = UIView()

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

    private let popularHeaderLabel = UILabel()
    private let seeAllButton = UIButton(type: .system)
    private let popularScrollView = UIScrollView()
    private let popularStack = UIStackView()
    private let topBlur = TopBlurView()

    var onQuizSelected: ((ExploreQuizItem) -> Void)?
    var onContinueTapped: ((ExploreQuizItem) -> Void)?
    private var continueItem: ExploreQuizItem?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(user: User, stats: UserStats) {
        let firstName = user.name.components(separatedBy: " ").first ?? user.name
        titleLabel.text = "Hi, \(firstName)!"
        greetingLabel.text = timeGreeting()
        streakCountLabel.text = "\(stats.currentStreak)"

        // Continue card — prefer in-progress quiz, fall back to last completed
        if let inProgress = StatsManager.shared.inProgressQuiz,
           let match = ExploreQuizMockData.allQuizzes.first(where: { $0.title == inProgress.title }) {
            continueTitleLabel.text = match.title
            progressLabel.text = "Tap to continue"
            continueItem = match
            continueCard.alpha = 1
        } else if let recent = stats.recentQuizzes.first,
                  let match = ExploreQuizMockData.allQuizzes.first(where: { $0.title == recent.title }) {
            continueTitleLabel.text = match.title
            progressLabel.text = "\(recent.score)/\(recent.total) · play again"
            continueItem = match
            continueCard.alpha = 1
        } else {
            continueCard.alpha = 0.4
            continueItem = nil
        }

        // Popular cards — top quiz from each category
        popularStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        ExploreQuizMockData.topPerCategory.enumerated().forEach { idx, item in
            let card = makePopularCard(item: item)
            let tap = UITapGestureRecognizer(target: self, action: #selector(popularCardTapped(_:)))
            card.addGestureRecognizer(tap)
            card.isUserInteractionEnabled = true
            card.tag = idx
            popularStack.addArrangedSubview(card)
        }
    }
}

private extension HomeView {

    @objc func continueCardTapped() {
        guard let item = continueItem else { return }
        onContinueTapped?(item)
    }

    @objc func popularCardTapped(_ gesture: UITapGestureRecognizer) {
        guard let card = gesture.view else { return }
        let quizzes = ExploreQuizMockData.topPerCategory
        let idx = quizzes.indices.contains(card.tag) ? card.tag : 0
        onQuizSelected?(quizzes[idx])
    }

    func timeGreeting() -> String {
        let h = Calendar.current.component(.hour, from: Date())
        switch h {
        case 5..<12:  return "Good morning 🌤️"
        case 12..<17: return "Good afternoon ☀️"
        case 17..<21: return "Good evening 🌅"
        default:      return "Good night 🌙"
        }
    }

    func setupUI() {
        backgroundColor = UIColor(hex: "f8fafc")
        setupScrollView()
        setupHeader()
        setupContinueCard()
        setupDailyChallenge()
        setupPopular()
    }

    func setupScrollView() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
    }

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

        let tap = UITapGestureRecognizer(target: self, action: #selector(continueCardTapped))
        continueCard.addGestureRecognizer(tap)
        continueCard.isUserInteractionEnabled = true
        continueCard.alpha = 0.4
    }

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

        popularScrollView.addSubview(popularStack)

        // Seed with top-per-category before configure is called
        ExploreQuizMockData.topPerCategory.enumerated().forEach { idx, item in
            let card = makePopularCard(item: item)
            let tap = UITapGestureRecognizer(target: self, action: #selector(popularCardTapped(_:)))
            card.addGestureRecognizer(tap)
            card.isUserInteractionEnabled = true
            card.tag = idx
            popularStack.addArrangedSubview(card)
        }
    }

    func makePopularCard(item: ExploreQuizItem) -> UIView {
        let colors = [UIColor(hex: item.thumbnailGradientStartHex), UIColor(hex: item.thumbnailGradientEndHex)]
        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 24
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.07
        card.layer.shadowOffset = CGSize(width: 0, height: 4)
        card.layer.shadowRadius = 8

        let imageArea = GradientView(colors: colors)
        imageArea.layer.cornerRadius = 24
        imageArea.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageArea.clipsToBounds = true

        let emojiLabel = UILabel()
        emojiLabel.text = item.emoji
        emojiLabel.font = .systemFont(ofSize: 46)

        let categoryBadge = makeCardBadge(title: item.categoryLabel)
        let diffBadge = makeCardBadge(title: item.difficulty.title)

        let titleLabel = UILabel()
        titleLabel.text = item.title
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = UIColor(hex: "0f172a")
        titleLabel.numberOfLines = 2

        let metaStack = UIStackView()
        metaStack.axis = .horizontal
        metaStack.spacing = 8
        metaStack.alignment = .center
        metaStack.addArrangedSubview(makeMetaItem(icon: "star.fill", text: item.rating))
        metaStack.addArrangedSubview(makeMetaItem(icon: "clock", text: item.duration))
        metaStack.addArrangedSubview(makeMetaItem(icon: "person.2", text: item.participants))

        imageArea.addSubview(emojiLabel)
        imageArea.addSubview(categoryBadge)
        imageArea.addSubview(diffBadge)
        card.addSubview(imageArea)
        card.addSubview(titleLabel)
        card.addSubview(metaStack)

        card.snp.makeConstraints { $0.width.equalTo(200) }
        imageArea.snp.makeConstraints { $0.top.leading.trailing.equalToSuperview(); $0.height.equalTo(120) }
        emojiLabel.snp.makeConstraints { $0.trailing.equalToSuperview().inset(10); $0.top.equalToSuperview().inset(12) }
        categoryBadge.snp.makeConstraints { $0.leading.equalToSuperview().inset(14); $0.bottom.equalToSuperview().inset(12); $0.height.equalTo(22) }
        diffBadge.snp.makeConstraints { $0.leading.equalTo(categoryBadge.snp.trailing).offset(6); $0.bottom.equalToSuperview().inset(12); $0.height.equalTo(22) }
        titleLabel.snp.makeConstraints { $0.top.equalTo(imageArea.snp.bottom).offset(12); $0.leading.trailing.equalToSuperview().inset(14) }
        metaStack.snp.makeConstraints { $0.top.equalTo(titleLabel.snp.bottom).offset(8); $0.leading.equalToSuperview().inset(14); $0.trailing.lessThanOrEqualToSuperview().inset(14); $0.bottom.equalToSuperview().inset(12) }

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

    func setupConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        [greetingLabel, titleLabel, streakBadge, bellButton,
         continueCard,
         challengeHeaderLabel, challengeTimerLabel, challengeCard,
         popularHeaderLabel, seeAllButton, popularScrollView].forEach {
            contentView.addSubview($0)
        }

        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }

        greetingLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.safeTop)
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

        popularHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(challengeCard.snp.bottom).offset(24)
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

        addSubview(topBlur)
        topBlur.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.top).offset(64)
        }
        scrollView.delegate = self
    }
}

extension HomeView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        topBlur.update(scrollOffset: scrollView.contentOffset.y)
    }
}
