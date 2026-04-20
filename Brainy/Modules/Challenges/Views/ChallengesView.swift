import UIKit
import SnapKit

private final class ChallengesGradientView: UIView {
    private let gradientLayer = CAGradientLayer()

    init(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
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

final class ChallengesView: UIView {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    private let weeklyHeaderLabel = UILabel()
    private let weeklyCard = ChallengesGradientView(
        colors: [UIColor(hex: "4f46e5"), UIColor(hex: "7c3aed")],
        startPoint: CGPoint(x: 0.09, y: 0.0),
        endPoint: CGPoint(x: 0.95, y: 1.0)
    )
    private let weeklyDecorationCircle = UIView()
    private let weeklyBrainLabel = UILabel()
    private let weeklyDaysBadge = UIView()
    private let weeklyDaysLabel = UILabel()
    private let weeklyTitleLabel = UILabel()
    private let weeklySubtitleLabel = UILabel()
    private let weeklyBoltIcon = UIImageView()
    private let weeklyXPMainLabel = UILabel()
    private let weeklyXPUnitLabel = UILabel()
    private let weeklyProgressCaption = UILabel()
    private let weeklyProgressValue = UILabel()
    private let weeklyProgressTrack = UIView()
    private let weeklyProgressFill = UIView()
    private let weeklyTopRow = UIStackView()
    private let weeklyProgressBlock = UIStackView()

    private let dailyHeaderLabel = UILabel()
    private let dailyStack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(stats: UserStats) {
        // Weekly challenge
        let done = min(stats.weeklyQuizzesPlayed, 5)
        weeklyProgressValue.text = "\(done)/5"
        let progress = CGFloat(done) / 5.0
        weeklyProgressFill.snp.remakeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(max(progress, 0.01))
        }
        let days = daysLeftInWeek(from: stats.weekStartDate)
        weeklyDaysLabel.text = days == 1 ? "1 day left" : "\(days) days left"

        // Daily missions
        dailyStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        [
            makeSpeedRoundCard(isCompleted: stats.todayQuizzesPlayed > 0),
            makePerfectScoreCard(isCompleted: stats.hasPerfectScoreToday),
            makeStreakKeeperCard(isCompleted: stats.currentStreak > 0)
        ].forEach { dailyStack.addArrangedSubview($0) }
    }

    private func daysLeftInWeek(from start: Date?) -> Int {
        guard let start else { return 7 }
        let days = Calendar.current.dateComponents([.day], from: start, to: Date()).day ?? 0
        return max(0, 7 - days)
    }
}

private extension ChallengesView {

    func setupUI() {
        backgroundColor = UIColor(hex: "f8fafc")

        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true

        titleLabel.text = "Challenges"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = UIColor(hex: "0f172a")

        subtitleLabel.text = "Complete challenges to earn bonus XP"
        subtitleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        subtitleLabel.textColor = UIColor(hex: "64748b")

        weeklyHeaderLabel.text = "🗓 Weekly Challenge"
        weeklyHeaderLabel.font = .systemFont(ofSize: 18, weight: .bold)
        weeklyHeaderLabel.textColor = UIColor(hex: "0f172a")

        weeklyCard.layer.cornerRadius = 24
        weeklyCard.clipsToBounds = true

        weeklyDecorationCircle.backgroundColor = UIColor(white: 1, alpha: 0.08)
        weeklyDecorationCircle.layer.cornerRadius = 65

        weeklyBrainLabel.text = "🧠"
        weeklyBrainLabel.font = .systemFont(ofSize: 24)

        weeklyDaysBadge.backgroundColor = UIColor(white: 1, alpha: 0.2)
        weeklyDaysBadge.layer.cornerRadius = 8

        weeklyDaysLabel.text = "4 days left"
        weeklyDaysLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        weeklyDaysLabel.textColor = .white

        weeklyTitleLabel.text = "Weekly Mastermind"
        weeklyTitleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        weeklyTitleLabel.textColor = .white

        weeklySubtitleLabel.text = "Complete 5 different category quizzes this week."
        weeklySubtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        weeklySubtitleLabel.textColor = UIColor(white: 1, alpha: 0.75)
        weeklySubtitleLabel.numberOfLines = 2

        weeklyBoltIcon.image = UIImage(systemName: "bolt.fill")?.withRenderingMode(.alwaysTemplate)
        weeklyBoltIcon.tintColor = .white
        weeklyBoltIcon.contentMode = .scaleAspectFit

        weeklyXPMainLabel.text = "+1000"
        weeklyXPMainLabel.font = .systemFont(ofSize: 14, weight: .bold)
        weeklyXPMainLabel.textColor = .white
        weeklyXPMainLabel.textAlignment = .center

        weeklyXPUnitLabel.text = "XP"
        weeklyXPUnitLabel.font = .systemFont(ofSize: 10, weight: .regular)
        weeklyXPUnitLabel.textColor = UIColor(white: 1, alpha: 0.7)
        weeklyXPUnitLabel.textAlignment = .center

        weeklyProgressCaption.text = "Progress"
        weeklyProgressCaption.font = .systemFont(ofSize: 13, weight: .regular)
        weeklyProgressCaption.textColor = UIColor(white: 1, alpha: 0.8)

        weeklyProgressValue.text = "3/5"
        weeklyProgressValue.font = .systemFont(ofSize: 13, weight: .bold)
        weeklyProgressValue.textColor = .white

        weeklyProgressTrack.backgroundColor = UIColor(white: 1, alpha: 0.2)
        weeklyProgressTrack.layer.cornerRadius = 4

        weeklyProgressFill.backgroundColor = .white
        weeklyProgressFill.layer.cornerRadius = 4

        dailyHeaderLabel.text = "⚡ Daily Missions"
        dailyHeaderLabel.font = .systemFont(ofSize: 18, weight: .bold)
        dailyHeaderLabel.textColor = UIColor(hex: "0f172a")

        dailyStack.axis = .vertical
        dailyStack.spacing = 12
        dailyStack.alignment = .fill
        [makeSpeedRoundCard(isCompleted: false), makePerfectScoreCard(isCompleted: false), makeStreakKeeperCard(isCompleted: false)].forEach { dailyStack.addArrangedSubview($0) }

        let daysRow = UIStackView(arrangedSubviews: [weeklyBrainLabel, weeklyDaysBadge])
        daysRow.axis = .horizontal
        daysRow.spacing = 8
        daysRow.alignment = .center

        weeklyDaysBadge.addSubview(weeklyDaysLabel)
        weeklyDaysLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(3)
        }

        let textColumn = UIStackView(arrangedSubviews: [daysRow, weeklyTitleLabel, weeklySubtitleLabel])
        textColumn.axis = .vertical
        textColumn.spacing = 4
        textColumn.alignment = .leading

        let xpColumn = UIStackView(arrangedSubviews: [weeklyBoltIcon, weeklyXPMainLabel, weeklyXPUnitLabel])
        xpColumn.axis = .vertical
        xpColumn.spacing = 4
        xpColumn.alignment = .center

        weeklyTopRow.axis = .horizontal
        weeklyTopRow.alignment = .top
        weeklyTopRow.spacing = 12
        [textColumn, xpColumn].forEach { weeklyTopRow.addArrangedSubview($0) }

        let progressHeader = UIStackView(arrangedSubviews: [weeklyProgressCaption, weeklyProgressValue])
        progressHeader.axis = .horizontal
        progressHeader.distribution = .equalSpacing

        weeklyProgressTrack.addSubview(weeklyProgressFill)

        weeklyProgressBlock.axis = .vertical
        weeklyProgressBlock.spacing = 8
        weeklyProgressBlock.alignment = .fill
        [progressHeader, weeklyProgressTrack].forEach { weeklyProgressBlock.addArrangedSubview($0) }

        [weeklyDecorationCircle, weeklyTopRow, weeklyProgressBlock].forEach { weeklyCard.addSubview($0) }

    }

    func setupConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        [titleLabel, subtitleLabel,
         weeklyHeaderLabel, weeklyCard,
         dailyHeaderLabel, dailyStack].forEach { contentView.addSubview($0) }

        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.safeTop)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        weeklyHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        weeklyCard.snp.makeConstraints {
            $0.top.equalTo(weeklyHeaderLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(202)
        }

        weeklyDecorationCircle.snp.makeConstraints {
            $0.size.equalTo(130)
            $0.top.equalToSuperview().offset(-30)
            $0.trailing.equalToSuperview().offset(-8)
        }

        weeklyTopRow.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(20)
        }

        weeklyBoltIcon.snp.makeConstraints { $0.size.equalTo(16) }

        weeklyProgressBlock.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }

        weeklyProgressTrack.snp.makeConstraints { $0.height.equalTo(8) }

        weeklyProgressFill.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.6)
        }

        dailyHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(weeklyCard.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        dailyStack.snp.makeConstraints {
            $0.top.equalTo(dailyHeaderLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
}

private extension ChallengesView {

    func cardContainerShadow(_ v: UIView) {
        v.backgroundColor = .white
        v.layer.cornerRadius = 20
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.06
        v.layer.shadowOffset = CGSize(width: 0, height: 2)
        v.layer.shadowRadius = 12
    }

    func makeSpeedRoundCard(isCompleted: Bool) -> UIView {
        let row = UIView()
        cardContainerShadow(row)

        let iconBg = UIView()
        iconBg.backgroundColor = UIColor(hex: "fef3c7")
        iconBg.layer.cornerRadius = 16

        let emoji = UILabel()
        emoji.text = "⚡"
        emoji.font = .systemFont(ofSize: 24)

        let title = UILabel()
        title.text = "Speed Round"
        title.font = .systemFont(ofSize: 15, weight: .bold)
        title.textColor = UIColor(hex: "0f172a")

        let desc = UILabel()
        desc.text = "Answer 5 questions in under 60 seconds!"
        desc.font = .systemFont(ofSize: 13, weight: .regular)
        desc.textColor = UIColor(hex: "64748b")
        desc.numberOfLines = 2

        let xp = xpRow(icon: "bolt.fill", text: "+200 XP", tint: UIColor(hex: "f59e0b"))
        let textStack = UIStackView(arrangedSubviews: [title, desc, xp])
        textStack.axis = .vertical
        textStack.spacing = 8
        textStack.setCustomSpacing(4, after: title)

        let accessory = makeAccessory(isCompleted: isCompleted)
        iconBg.addSubview(emoji)
        emoji.snp.makeConstraints { $0.center.equalToSuperview() }
        [iconBg, textStack, accessory].forEach { row.addSubview($0) }
        iconBg.snp.makeConstraints { $0.leading.equalToSuperview().inset(16); $0.centerY.equalToSuperview(); $0.size.equalTo(52) }
        textStack.snp.makeConstraints { $0.leading.equalTo(iconBg.snp.trailing).offset(14); $0.top.bottom.equalToSuperview().inset(16); $0.trailing.equalTo(accessory.snp.leading).offset(-12) }
        accessory.snp.makeConstraints { $0.trailing.equalToSuperview().inset(16); $0.centerY.equalToSuperview() }
        row.snp.makeConstraints { $0.height.greaterThanOrEqualTo(100) }
        return row
    }

    func makePerfectScoreCard(isCompleted: Bool) -> UIView {
        let row = UIView()
        cardContainerShadow(row)

        let iconBg = UIView()
        iconBg.backgroundColor = UIColor(hex: "eef2ff")
        iconBg.layer.cornerRadius = 16

        let emoji = UILabel()
        emoji.text = "⭐"
        emoji.font = .systemFont(ofSize: 24)

        let title = UILabel()
        title.text = "Perfect Score"
        title.font = .systemFont(ofSize: 15, weight: .bold)
        title.textColor = UIColor(hex: "0f172a")

        let desc = UILabel()
        desc.text = "Get 100% on any Medium or Hard quiz."
        desc.font = .systemFont(ofSize: 13, weight: .regular)
        desc.textColor = UIColor(hex: "64748b")
        desc.numberOfLines = 2

        let xp = xpRow(icon: "bolt.fill", text: "+300 XP", tint: UIColor(hex: "4f46e5"))
        let textStack = UIStackView(arrangedSubviews: [title, desc, xp])
        textStack.axis = .vertical
        textStack.spacing = 8

        let accessory = makeAccessory(isCompleted: isCompleted)
        iconBg.addSubview(emoji)
        emoji.snp.makeConstraints { $0.center.equalToSuperview() }
        [iconBg, textStack, accessory].forEach { row.addSubview($0) }
        iconBg.snp.makeConstraints { $0.leading.equalToSuperview().inset(16); $0.centerY.equalToSuperview(); $0.size.equalTo(52) }
        textStack.snp.makeConstraints { $0.leading.equalTo(iconBg.snp.trailing).offset(14); $0.top.bottom.equalToSuperview().inset(16); $0.trailing.equalTo(accessory.snp.leading).offset(-12) }
        accessory.snp.makeConstraints { $0.trailing.equalToSuperview().inset(16); $0.centerY.equalToSuperview() }
        row.snp.makeConstraints { $0.height.greaterThanOrEqualTo(100) }
        return row
    }

    func makeStreakKeeperCard(isCompleted: Bool) -> UIView {
        let row = UIView()
        cardContainerShadow(row)

        let iconBg = UIView()
        iconBg.backgroundColor = UIColor(hex: "fee2e2")
        iconBg.layer.cornerRadius = 16

        let emoji = UILabel()
        emoji.text = "🔥"
        emoji.font = .systemFont(ofSize: 24)

        let title = UILabel()
        title.text = "Streak Keeper"
        title.font = .systemFont(ofSize: 15, weight: .bold)
        title.textColor = UIColor(hex: "0f172a")

        let streakDot = UIView()
        streakDot.backgroundColor = UIColor(hex: "22c55e")
        streakDot.layer.cornerRadius = 8

        let titleRow = UIStackView(arrangedSubviews: [title, streakDot])
        titleRow.axis = .horizontal
        titleRow.spacing = 8
        titleRow.alignment = .center

        let desc = UILabel()
        desc.text = "Complete any quiz to maintain your streak."
        desc.font = .systemFont(ofSize: 13, weight: .regular)
        desc.textColor = UIColor(hex: "64748b")
        desc.numberOfLines = 2

        let xp = xpRow(icon: "bolt.fill", text: "+100 XP", tint: UIColor(hex: "ef4444"))
        let textStack = UIStackView(arrangedSubviews: [titleRow, desc, xp])
        textStack.axis = .vertical
        textStack.spacing = 8

        streakDot.snp.makeConstraints { $0.size.equalTo(16) }

        let accessory = makeAccessory(isCompleted: isCompleted)
        iconBg.addSubview(emoji)
        emoji.snp.makeConstraints { $0.center.equalToSuperview() }
        [iconBg, textStack, accessory].forEach { row.addSubview($0) }
        iconBg.snp.makeConstraints { $0.leading.equalToSuperview().inset(16); $0.centerY.equalToSuperview(); $0.size.equalTo(52) }
        textStack.snp.makeConstraints { $0.leading.equalTo(iconBg.snp.trailing).offset(14); $0.top.bottom.equalToSuperview().inset(16); $0.trailing.equalTo(accessory.snp.leading).offset(-12) }
        accessory.snp.makeConstraints { $0.trailing.equalToSuperview().inset(16); $0.centerY.equalToSuperview() }
        row.snp.makeConstraints { $0.height.greaterThanOrEqualTo(100) }
        return row
    }

    func makeAccessory(isCompleted: Bool) -> UIView {
        if isCompleted {
            let wrap = UIView()
            wrap.backgroundColor = UIColor(hex: "dcfce7")
            wrap.layer.cornerRadius = 10
            let check = UIImageView(image: UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate))
            check.tintColor = UIColor(hex: "16a34a")
            check.contentMode = .scaleAspectFit
            wrap.addSubview(check)
            check.snp.makeConstraints { $0.center.equalToSuperview(); $0.size.equalTo(16) }
            wrap.snp.makeConstraints { $0.size.equalTo(32) }
            return wrap
        } else {
            let iv = UIImageView(image: UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate))
            iv.tintColor = UIColor(hex: "cbd5e1")
            iv.contentMode = .scaleAspectFit
            iv.snp.makeConstraints { $0.size.equalTo(18) }
            return iv
        }
    }

    func xpRow(icon: String, text: String, tint: UIColor) -> UIView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center

        let iv = UIImageView(image: UIImage(systemName: icon)?.withRenderingMode(.alwaysTemplate))
        iv.tintColor = tint
        iv.contentMode = .scaleAspectFit
        iv.snp.makeConstraints { $0.size.equalTo(12) }

        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = tint

        stack.addArrangedSubview(iv)
        stack.addArrangedSubview(label)
        return stack
    }

}
