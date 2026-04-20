import UIKit
import SnapKit

final class RanksView: UIView {

    // MARK: - Types

    private enum Trend { case up, down, neutral }
    private enum Period { case today, week, month }

    private struct Entry {
        let rank: Int
        let initials: String
        let color: UIColor
        let name: String
        let level: Int
        let username: String
        let points: Int
        let trend: Trend
        let isMe: Bool
    }

    // MARK: - Data

    private let entriesByPeriod: [Period: [Entry]] = [
        .today: [
            Entry(rank: 1,  initials: "SC", color: UIColor(hex: "4f46e5"), name: "Sofia Chen",    level: 35, username: "@sofia_c",  points: 2800,  trend: .up,      isMe: false),
            Entry(rank: 2,  initials: "LW", color: UIColor(hex: "22c55e"), name: "Liam Walsh",    level: 32, username: "@liamw",    points: 2100,  trend: .up,      isMe: false),
            Entry(rank: 3,  initials: "NK", color: UIColor(hex: "f59e0b"), name: "Noah Kim",      level: 29, username: "@noahk",    points: 1950,  trend: .down,    isMe: false),
            Entry(rank: 4,  initials: "AT", color: UIColor(hex: "4f46e5"), name: "Alex Torres",   level: 22, username: "@alex_t",   points: 1640,  trend: .up,      isMe: true),
            Entry(rank: 5,  initials: "ED", color: UIColor(hex: "a855f7"), name: "Emma Davis",    level: 27, username: "@emmad",    points: 1500,  trend: .neutral, isMe: false),
            Entry(rank: 6,  initials: "JB", color: UIColor(hex: "ef4444"), name: "James Brown",   level: 25, username: "@jamesb",   points: 1380,  trend: .down,    isMe: false),
            Entry(rank: 7,  initials: "ML", color: UIColor(hex: "14b8a6"), name: "Mia Lopez",     level: 20, username: "@mialopez", points: 920,   trend: .up,      isMe: false),
        ],
        .week: [
            Entry(rank: 1,  initials: "SC", color: UIColor(hex: "4f46e5"), name: "Sofia Chen",    level: 35, username: "@sofia_c",  points: 15800, trend: .up,      isMe: false),
            Entry(rank: 2,  initials: "ML2", color: UIColor(hex: "06b6d4"), name: "Marcus Lee",   level: 33, username: "@marcusl",  points: 14300, trend: .up,      isMe: false),
            Entry(rank: 3,  initials: "AJ", color: UIColor(hex: "ec4899"), name: "Aria Johnson",  level: 31, username: "@ariaj",    points: 13800, trend: .down,    isMe: false),
            Entry(rank: 4,  initials: "LW", color: UIColor(hex: "22c55e"), name: "Liam Walsh",    level: 32, username: "@liamw",    points: 12100, trend: .up,      isMe: false),
            Entry(rank: 5,  initials: "NK", color: UIColor(hex: "f59e0b"), name: "Noah Kim",      level: 29, username: "@noahk",    points: 11200, trend: .up,      isMe: false),
            Entry(rank: 6,  initials: "ED", color: UIColor(hex: "a855f7"), name: "Emma Davis",    level: 27, username: "@emmad",    points: 10500, trend: .down,    isMe: false),
            Entry(rank: 7,  initials: "JB", color: UIColor(hex: "ef4444"), name: "James Brown",   level: 25, username: "@jamesb",   points: 9800,  trend: .neutral, isMe: false),
            Entry(rank: 8,  initials: "AT", color: UIColor(hex: "4f46e5"), name: "Alex Torres",   level: 22, username: "@alex_t",   points: 8640,  trend: .up,      isMe: true),
            Entry(rank: 9,  initials: "ML", color: UIColor(hex: "14b8a6"), name: "Mia Lopez",     level: 20, username: "@mialopez", points: 7920,  trend: .down,    isMe: false),
            Entry(rank: 10, initials: "OP", color: UIColor(hex: "6366f1"), name: "Oliver Park",   level: 18, username: "@oliverp",  points: 7100,  trend: .neutral, isMe: false),
        ],
        .month: [
            Entry(rank: 1,  initials: "LW", color: UIColor(hex: "22c55e"), name: "Liam Walsh",    level: 32, username: "@liamw",    points: 48200, trend: .up,      isMe: false),
            Entry(rank: 2,  initials: "SC", color: UIColor(hex: "4f46e5"), name: "Sofia Chen",    level: 35, username: "@sofia_c",  points: 45100, trend: .down,    isMe: false),
            Entry(rank: 3,  initials: "NK", color: UIColor(hex: "f59e0b"), name: "Noah Kim",      level: 29, username: "@noahk",    points: 41600, trend: .up,      isMe: false),
            Entry(rank: 4,  initials: "ED", color: UIColor(hex: "a855f7"), name: "Emma Davis",    level: 27, username: "@emmad",    points: 38900, trend: .up,      isMe: false),
            Entry(rank: 5,  initials: "AJ", color: UIColor(hex: "ec4899"), name: "Aria Johnson",  level: 31, username: "@ariaj",    points: 35400, trend: .neutral, isMe: false),
            Entry(rank: 6,  initials: "AT", color: UIColor(hex: "4f46e5"), name: "Alex Torres",   level: 22, username: "@alex_t",   points: 29800, trend: .up,      isMe: true),
            Entry(rank: 7,  initials: "JB", color: UIColor(hex: "ef4444"), name: "James Brown",   level: 25, username: "@jamesb",   points: 27300, trend: .down,    isMe: false),
            Entry(rank: 8,  initials: "ML", color: UIColor(hex: "14b8a6"), name: "Mia Lopez",     level: 20, username: "@mialopez", points: 24100, trend: .up,      isMe: false),
            Entry(rank: 9,  initials: "OP", color: UIColor(hex: "6366f1"), name: "Oliver Park",   level: 18, username: "@oliverp",  points: 21500, trend: .neutral, isMe: false),
            Entry(rank: 10, initials: "ML2", color: UIColor(hex: "06b6d4"), name: "Marcus Lee",   level: 33, username: "@marcusl",  points: 19800, trend: .down,    isMe: false),
        ],
    ]

    private var currentPeriod: Period = .week {
        didSet { reloadContent() }
    }

    // MARK: - Subviews

    private let scrollView: UIScrollView = {
        let s = UIScrollView()
        s.showsVerticalScrollIndicator = false
        s.alwaysBounceVertical = true
        return s
    }()
    private let contentView = UIView()

    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Leaderboard"
        l.font = .systemFont(ofSize: 28, weight: .bold)
        l.textColor = UIColor(hex: "0f172a")
        return l
    }()

    private let todayBtn    = RanksView.filterBtn("Today",      active: false)
    private let weekBtn     = RanksView.filterBtn("This Week",  active: true)
    private let monthBtn    = RanksView.filterBtn("This Month", active: false)

    private let podiumView = UIView()
    private let podiumGradient = CAGradientLayer()

    private lazy var listStack: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = 12
        return s
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        bindButtons()
    }
    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        podiumGradient.frame = podiumView.bounds
    }

    // MARK: - Factory

    private static func filterBtn(_ title: String, active: Bool) -> UIButton {
        let b = UIButton(type: .system)
        b.setTitle(title, for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        if active {
            b.setTitleColor(.white, for: .normal)
            b.backgroundColor = UIColor(hex: "4f46e5")
            b.layer.borderWidth = 0
        } else {
            b.setTitleColor(UIColor(hex: "64748b"), for: .normal)
            b.backgroundColor = .white
            b.layer.borderColor = UIColor(hex: "e2e8f0").cgColor
            b.layer.borderWidth = 1.5
        }
        b.layer.cornerRadius = 10
        b.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        return b
    }
}

// MARK: - Setup

private extension RanksView {

    func setupUI() {
        backgroundColor = UIColor(hex: "f8fafc")

        podiumGradient.colors = [UIColor(hex: "3730a3").cgColor, UIColor(hex: "4f46e5").cgColor]
        podiumGradient.startPoint = CGPoint(x: 0.08, y: 0.08)
        podiumGradient.endPoint = CGPoint(x: 0.91, y: 0.91)
        podiumView.layer.insertSublayer(podiumGradient, at: 0)
        podiumView.clipsToBounds = true

        reloadContent()
    }

    func setupConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        [titleLabel, todayBtn, weekBtn, monthBtn, podiumView, listStack].forEach {
            contentView.addSubview($0)
        }

        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalToSuperview().offset(24)
        }

        todayBtn.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(32)
        }
        weekBtn.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(todayBtn.snp.trailing).offset(8)
            $0.height.equalTo(32)
        }
        monthBtn.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(weekBtn.snp.trailing).offset(8)
            $0.height.equalTo(32)
        }

        podiumView.snp.makeConstraints {
            $0.top.equalTo(todayBtn.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(278)
        }
        listStack.snp.makeConstraints {
            $0.top.equalTo(podiumView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-24)
        }
    }

    func bindButtons() {
        todayBtn.addTarget(self, action: #selector(didTapToday), for: .touchUpInside)
        weekBtn.addTarget(self, action: #selector(didTapWeek), for: .touchUpInside)
        monthBtn.addTarget(self, action: #selector(didTapMonth), for: .touchUpInside)
    }

    @objc func didTapToday()  { currentPeriod = .today }
    @objc func didTapWeek()   { currentPeriod = .week }
    @objc func didTapMonth()  { currentPeriod = .month }

    func setActive(_ btn: UIButton) {
        for b in [todayBtn, weekBtn, monthBtn] {
            let isActive = b === btn
            b.setTitleColor(isActive ? .white : UIColor(hex: "64748b"), for: .normal)
            b.backgroundColor = isActive ? UIColor(hex: "4f46e5") : .white
            b.layer.borderColor = UIColor(hex: "e2e8f0").cgColor
            b.layer.borderWidth = isActive ? 0 : 1.5
        }
    }

    // MARK: - Reload

    func reloadContent() {
        let activeBtn: UIButton
        switch currentPeriod {
        case .today: activeBtn = todayBtn
        case .week:  activeBtn = weekBtn
        case .month: activeBtn = monthBtn
        }
        setActive(activeBtn)

        let entries = entriesByPeriod[currentPeriod] ?? []
        let top3 = Array(entries.prefix(3))
        let rest = Array(entries.dropFirst(3))

        rebuildPodium(top3: top3)

        listStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        rest.forEach { listStack.addArrangedSubview(makeEntryRow($0)) }
    }

    // MARK: - Podium

    private func rebuildPodium(top3: [Entry]) {
        podiumView.subviews.forEach { $0.removeFromSuperview() }

        let circle1 = UIView()
        circle1.backgroundColor = UIColor.white.withAlphaComponent(0.06)
        circle1.layer.cornerRadius = 100
        podiumView.addSubview(circle1)
        circle1.snp.makeConstraints {
            $0.width.height.equalTo(200)
            $0.leading.equalToSuperview().offset(233)
            $0.top.equalToSuperview().offset(-40)
        }

        let circle2 = UIView()
        circle2.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        circle2.layer.cornerRadius = 90
        podiumView.addSubview(circle2)
        circle2.snp.makeConstraints {
            $0.width.height.equalTo(180)
            $0.leading.equalToSuperview().offset(-40)
            $0.top.equalToSuperview().offset(158)
        }

        guard top3.count >= 3 else { return }

        let firstCol  = makePodiumColumn(entry: top3[0], barH: 88,  barAlpha: 0.20, crown: true,  borderColor: UIColor(hex: "fcd34d"), rankColor: UIColor(hex: "fcd34d"), rankSize: 26)
        let secondCol = makePodiumColumn(entry: top3[1], barH: 64,  barAlpha: 0.15, crown: false, borderColor: UIColor(hex: "c0c0c0"), rankColor: UIColor(hex: "c0c0c0"), rankSize: 22)
        let thirdCol  = makePodiumColumn(entry: top3[2], barH: 48,  barAlpha: 0.12, crown: false, borderColor: UIColor(hex: "cd7f32"), rankColor: UIColor(hex: "cd7f32"), rankSize: 20)

        [secondCol, firstCol, thirdCol].forEach { podiumView.addSubview($0) }

        secondCol.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(36)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(80)
        }
        firstCol.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(80)
        }
        thirdCol.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-36)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(80)
        }
    }

    private func makePodiumColumn(
        entry: Entry,
        barH: CGFloat, barAlpha: CGFloat,
        crown: Bool,
        borderColor: UIColor, rankColor: UIColor, rankSize: CGFloat
    ) -> UIView {
        let col = UIView()

        let bar = UIView()
        bar.backgroundColor = UIColor.white.withAlphaComponent(barAlpha)
        bar.layer.cornerRadius = 12
        bar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        col.addSubview(bar)
        bar.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(barH)
        }

        let rankLbl = UILabel()
        rankLbl.text = entry.rank == 1 ? "1" : (entry.rank == 2 ? "2" : "3")
        rankLbl.font = .systemFont(ofSize: rankSize, weight: .heavy)
        rankLbl.textColor = rankColor
        rankLbl.textAlignment = .center
        bar.addSubview(rankLbl)
        rankLbl.snp.makeConstraints { $0.center.equalToSuperview() }

        let ptsLbl = UILabel()
        ptsLbl.text = formatPointsShort(entry.points)
        ptsLbl.font = .systemFont(ofSize: 11)
        ptsLbl.textColor = UIColor.white.withAlphaComponent(0.65)
        ptsLbl.textAlignment = .center
        col.addSubview(ptsLbl)
        ptsLbl.snp.makeConstraints {
            $0.bottom.equalTo(bar.snp.top).offset(-8)
            $0.centerX.equalToSuperview()
        }

        let nameLbl = UILabel()
        nameLbl.text = entry.name.components(separatedBy: " ").first ?? entry.name
        nameLbl.font = .systemFont(ofSize: 12, weight: .bold)
        nameLbl.textColor = .white
        nameLbl.textAlignment = .center
        col.addSubview(nameLbl)
        nameLbl.snp.makeConstraints {
            $0.bottom.equalTo(ptsLbl.snp.top).offset(-2)
            $0.centerX.equalToSuperview()
        }

        let avatar = UIView()
        avatar.backgroundColor = entry.color
        avatar.layer.cornerRadius = 18
        avatar.layer.borderColor = borderColor.cgColor
        avatar.layer.borderWidth = 3
        col.addSubview(avatar)
        avatar.snp.makeConstraints {
            $0.bottom.equalTo(nameLbl.snp.top).offset(-6)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(52)
        }

        let initLbl = UILabel()
        initLbl.text = entry.initials
        initLbl.font = .systemFont(ofSize: 16, weight: .bold)
        initLbl.textColor = .white
        initLbl.textAlignment = .center
        avatar.addSubview(initLbl)
        initLbl.snp.makeConstraints { $0.center.equalToSuperview() }

        if crown {
            let crownLbl = UILabel()
            crownLbl.text = "👑"
            crownLbl.font = .systemFont(ofSize: 18)
            crownLbl.textAlignment = .center
            col.addSubview(crownLbl)
            crownLbl.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.centerX.equalToSuperview()
                $0.bottom.equalTo(avatar.snp.top).offset(-4)
            }
        } else {
            avatar.snp.makeConstraints { $0.top.equalToSuperview() }
        }

        return col
    }

    // MARK: - List Row

    private func makeEntryRow(_ entry: Entry) -> UIView {
        let card = UIView()
        card.backgroundColor = entry.isMe ? UIColor(hex: "eef2ff") : .white
        card.layer.cornerRadius = 20
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.05
        card.layer.shadowOffset = CGSize(width: 0, height: 2)
        card.layer.shadowRadius = 4
        if entry.isMe {
            card.layer.borderColor = UIColor(hex: "4f46e5").cgColor
            card.layer.borderWidth = 2
        }
        card.snp.makeConstraints { $0.height.equalTo(66) }

        let rankLbl = UILabel()
        rankLbl.text = "#\(entry.rank)"
        rankLbl.font = .systemFont(ofSize: 16, weight: .heavy)
        rankLbl.textColor = entry.isMe ? UIColor(hex: "4f46e5") : UIColor(hex: "94a3b8")
        card.addSubview(rankLbl)
        rankLbl.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(32)
        }

        let avatar = UIView()
        avatar.backgroundColor = entry.color
        avatar.layer.cornerRadius = 14
        card.addSubview(avatar)
        avatar.snp.makeConstraints {
            $0.leading.equalTo(rankLbl.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(42)
        }

        let initLbl = UILabel()
        initLbl.text = entry.initials
        initLbl.font = .systemFont(ofSize: 13, weight: .bold)
        initLbl.textColor = .white
        initLbl.textAlignment = .center
        avatar.addSubview(initLbl)
        initLbl.snp.makeConstraints { $0.center.equalToSuperview() }

        let trendIcon = makeTrendIcon(entry.trend)
        card.addSubview(trendIcon)
        trendIcon.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(14)
        }

        let ptsLbl = UILabel()
        ptsLbl.text = formatPoints(entry.points)
        ptsLbl.font = .systemFont(ofSize: 16, weight: .heavy)
        ptsLbl.textColor = entry.isMe ? UIColor(hex: "4f46e5") : UIColor(hex: "0f172a")
        ptsLbl.textAlignment = .right
        card.addSubview(ptsLbl)
        ptsLbl.snp.makeConstraints {
            $0.trailing.equalTo(trendIcon.snp.leading).offset(-6)
            $0.top.equalToSuperview().offset(13)
        }

        let ptsUnitLbl = UILabel()
        ptsUnitLbl.text = "points"
        ptsUnitLbl.font = .systemFont(ofSize: 11)
        ptsUnitLbl.textColor = UIColor(hex: "94a3b8")
        ptsUnitLbl.textAlignment = .right
        card.addSubview(ptsUnitLbl)
        ptsUnitLbl.snp.makeConstraints {
            $0.trailing.equalTo(trendIcon.snp.leading).offset(-6)
            $0.bottom.equalToSuperview().offset(-13)
        }

        let nameLbl = UILabel()
        nameLbl.text = entry.name
        nameLbl.font = .systemFont(ofSize: 15, weight: .bold)
        nameLbl.textColor = UIColor(hex: "0f172a")
        card.addSubview(nameLbl)
        nameLbl.snp.makeConstraints {
            $0.leading.equalTo(avatar.snp.trailing).offset(12)
            $0.top.equalToSuperview().offset(13)
            $0.trailing.lessThanOrEqualTo(ptsLbl.snp.leading).offset(-8)
        }

        if entry.isMe {
            let youBadge = UILabel()
            youBadge.text = "YOU"
            youBadge.font = .systemFont(ofSize: 10, weight: .bold)
            youBadge.textColor = .white
            youBadge.backgroundColor = UIColor(hex: "4f46e5")
            youBadge.layer.cornerRadius = 6
            youBadge.clipsToBounds = true
            youBadge.textAlignment = .center
            card.addSubview(youBadge)
            youBadge.snp.makeConstraints {
                $0.leading.equalTo(nameLbl.snp.trailing).offset(6)
                $0.centerY.equalTo(nameLbl)
                $0.height.equalTo(17)
                $0.width.equalTo(34)
            }
        }

        let subtitleLbl = UILabel()
        subtitleLbl.text = "Level \(entry.level) · \(entry.username)"
        subtitleLbl.font = .systemFont(ofSize: 12)
        subtitleLbl.textColor = UIColor(hex: "94a3b8")
        card.addSubview(subtitleLbl)
        subtitleLbl.snp.makeConstraints {
            $0.leading.equalTo(avatar.snp.trailing).offset(12)
            $0.bottom.equalToSuperview().offset(-13)
            $0.trailing.lessThanOrEqualTo(ptsUnitLbl.snp.leading).offset(-8)
        }

        return card
    }

   private func makeTrendIcon(_ trend: Trend) -> UIImageView {
        let iv = UIImageView()
        let cfg = UIImage.SymbolConfiguration(pointSize: 10, weight: .bold)
        switch trend {
        case .up:
            iv.image = UIImage(systemName: "arrow.up.right", withConfiguration: cfg)
            iv.tintColor = UIColor(hex: "22c55e")
        case .down:
            iv.image = UIImage(systemName: "arrow.down.right", withConfiguration: cfg)
            iv.tintColor = UIColor(hex: "ef4444")
        case .neutral:
            iv.image = UIImage(systemName: "minus", withConfiguration: cfg)
            iv.tintColor = UIColor(hex: "94a3b8")
        }
        iv.contentMode = .scaleAspectFit
        return iv
    }

    func formatPoints(_ points: Int) -> String {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.groupingSeparator = ","
        return f.string(from: NSNumber(value: points)) ?? "\(points)"
    }

    func formatPointsShort(_ points: Int) -> String {
        if points >= 1000 {
            let k = Double(points) / 1000.0
            let s = k.truncatingRemainder(dividingBy: 1) == 0
                ? String(format: "%.0fk", k)
                : String(format: "%.1fk", k)
            return s
        }
        return "\(points)"
    }
}
