import UIKit
import SnapKit

// MARK: - Gradient helper

private final class ResultsHeaderGradient: UIView {
    private let gl = CAGradientLayer()
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        gl.colors = [UIColor(hex: "06b6d4").cgColor, UIColor(hex: "3b82f6").cgColor]
        gl.startPoint = CGPoint(x: 0.15, y: 0)
        gl.endPoint   = CGPoint(x: 0.85, y: 1)
        layer.insertSublayer(gl, at: 0)
    }
    required init?(coder: NSCoder) { fatalError() }
    override func layoutSubviews() { super.layoutSubviews(); gl.frame = bounds }
}

private final class PurpleGradientButton: UIControl {
    private let gl = CAGradientLayer()
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        gl.colors = [UIColor(hex: "4f46e5").cgColor, UIColor(hex: "7c3aed").cgColor]
        gl.startPoint = CGPoint(x: 0, y: 0)
        gl.endPoint   = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gl, at: 0)
        layer.cornerRadius = 18
        clipsToBounds = true
    }
    required init?(coder: NSCoder) { fatalError() }
    override func layoutSubviews() { super.layoutSubviews(); gl.frame = bounds }
    override var isHighlighted: Bool {
        didSet { alpha = isHighlighted ? 0.85 : 1 }
    }
}

// MARK: - QuizResultsView

final class QuizResultsView: UIView {

    var onRetry: (() -> Void)?
    var onShare: (() -> Void)?
    var onHome:  (() -> Void)?

    private weak var viewModel: QuizViewModel?

    // MARK: Header
    private let headerGradient = ResultsHeaderGradient()
    private let circle1 = UIView()
    private let circle2 = UIView()
    private let scoreCircle = UIView()
    private let scoreLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 44, weight: .heavy)
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()
    private let scoreDenomLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .semibold)
        l.textColor = UIColor.white.withAlphaComponent(0.7)
        l.textAlignment = .center
        return l
    }()
    private let motivationTitleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 22, weight: .heavy)
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()
    private let motivationSubLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .regular)
        l.textColor = UIColor.white.withAlphaComponent(0.8)
        l.textAlignment = .center
        l.numberOfLines = 2
        return l
    }()

    // MARK: Stats card
    private let statsCard: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 24
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.10
        v.layer.shadowRadius = 16
        v.layer.shadowOffset = CGSize(width: 0, height: 8)
        return v
    }()
    private let xpStat       = StatColumn()
    private let accuracyStat = StatColumn()
    private let timeStat     = StatColumn()

    // MARK: Breakdown
    private let breakdownTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Answer Breakdown"
        l.font = .systemFont(ofSize: 16, weight: .bold)
        l.textColor = UIColor(hex: "0f172a")
        return l
    }()
    private let breakdownCard: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 20
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.06
        v.layer.shadowRadius = 6
        v.layer.shadowOffset = CGSize(width: 0, height: 2)
        return v
    }()
    private let correctLegendLabel: UILabel = makeLegendLabel()
    private let wrongLegendLabel:   UILabel = makeLegendLabel()
    private let barBg: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "fee2e2")
        v.layer.cornerRadius = 5
        return v
    }()
    private let barFill: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "ef4444")
        v.layer.cornerRadius = 5
        return v
    }()
    private var barWrongFraction: CGFloat = 0.5
    private let dotsContainer = UIStackView()

    // MARK: Buttons
    private let retryButton  = PurpleGradientButton()
    private let shareButton  = SecondaryButton(icon: "square.and.arrow.up", title: "Share")
    private let homeButton   = SecondaryButton(icon: "house", title: "Home")

    private let retryLabel: UILabel = {
        let l = UILabel()
        l.text = "Retry Quiz"
        l.font = .systemFont(ofSize: 16, weight: .bold)
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()
    private let retryIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "arrow.clockwise"))
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    // MARK: Init

    init(viewModel: QuizViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        populate()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        let w = barBg.bounds.width * max(barWrongFraction, 0)
        barFill.snp.updateConstraints { $0.width.equalTo(max(w, 2)) }
    }

    // MARK: Populate

    private func populate() {
        guard let vm = viewModel else { return }

        scoreLabel.text     = "\(vm.correctCount)"
        scoreDenomLabel.text = "/ \(vm.totalQuestions)"
        motivationTitleLabel.text = vm.motivationTitle
        motivationSubLabel.text   = vm.motivationSubtitle

        xpStat.configure(emoji: "⚡", value: "+\(vm.xp)",
                         label: "Points Earned", color: UIColor(hex: "4f46e5"))
        accuracyStat.configure(emoji: "🎯", value: "\(vm.accuracyPercent)%",
                               label: "Accuracy", color: UIColor(hex: "22c55e"))
        timeStat.configure(emoji: "⏱️", value: vm.formattedTime,
                           label: "Time", color: UIColor(hex: "06b6d4"))

        correctLegendLabel.text = "\(vm.correctCount) Correct"
        wrongLegendLabel.text   = "\(vm.totalQuestions - vm.correctCount) Incorrect"
        barWrongFraction = CGFloat(vm.totalQuestions - vm.correctCount) / CGFloat(max(vm.totalQuestions, 1))
        setNeedsLayout()

        dotsContainer.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let results = vm.answerResults
        stride(from: 0, to: results.count, by: 8).forEach { start in
            let row = UIStackView()
            row.axis = .horizontal; row.spacing = 8; row.alignment = .center
            results[start..<min(start + 8, results.count)].forEach { correct in
                let dot = ResultDot(correct: correct)
                row.addArrangedSubview(dot)
            }
            row.addArrangedSubview(UIView())
            dotsContainer.addArrangedSubview(row)
        }
    }

    // MARK: Setup

    private func setupUI() {
        backgroundColor = UIColor(hex: "f8fafc")

        circle1.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        circle1.layer.cornerRadius = 90
        circle2.backgroundColor = UIColor.white.withAlphaComponent(0.06)
        circle2.layer.cornerRadius = 100

        scoreCircle.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        scoreCircle.layer.cornerRadius = 70
        scoreCircle.layer.borderWidth = 3
        scoreCircle.layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor

        dotsContainer.axis = .vertical
        dotsContainer.spacing = 8
        dotsContainer.alignment = .fill

        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        homeButton.addTarget(self, action: #selector(homeTapped),  for: .touchUpInside)
    }

    private func setupConstraints() {
        // Header
        addSubview(headerGradient)
        headerGradient.addSubview(circle1)
        headerGradient.addSubview(circle2)
        headerGradient.addSubview(scoreCircle)
        scoreCircle.addSubview(scoreLabel)
        scoreCircle.addSubview(scoreDenomLabel)
        headerGradient.addSubview(motivationTitleLabel)
        headerGradient.addSubview(motivationSubLabel)

        headerGradient.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.38)
        }
        circle1.snp.makeConstraints {
            $0.size.equalTo(180)
            $0.top.equalToSuperview().offset(-40)
            $0.trailing.equalToSuperview().offset(-20)
        }
        circle2.snp.makeConstraints {
            $0.size.equalTo(200)
            $0.bottom.equalToSuperview().offset(40)
            $0.leading.equalToSuperview().offset(-30)
        }
        scoreCircle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.size.equalTo(140)
        }
        scoreLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(28)
        }
        scoreDenomLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scoreLabel.snp.bottom).offset(-2)
        }
        motivationTitleLabel.snp.makeConstraints {
            $0.top.equalTo(scoreCircle.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        motivationSubLabel.snp.makeConstraints {
            $0.top.equalTo(motivationTitleLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        // Stats card — overlaps bottom of header
        addSubview(statsCard)
        let statsRow = UIStackView(arrangedSubviews: [xpStat, accuracyStat, timeStat])
        statsRow.axis = .horizontal
        statsRow.distribution = .fillEqually
        statsCard.addSubview(statsRow)

        statsCard.snp.makeConstraints {
            $0.top.equalTo(headerGradient.snp.bottom).offset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        statsRow.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(12)
        }

        // Breakdown
        addSubview(breakdownTitleLabel)
        addSubview(breakdownCard)

        let correctDot = LegendDot(color: UIColor(hex: "22c55e"))
        let wrongDot   = LegendDot(color: UIColor(hex: "ef4444"))
        let legendRow  = UIStackView(arrangedSubviews: [correctDot, correctLegendLabel,
                                                        UIView(),
                                                        wrongDot, wrongLegendLabel])
        legendRow.axis = .horizontal; legendRow.spacing = 6; legendRow.alignment = .center

        breakdownCard.addSubview(legendRow)
        breakdownCard.addSubview(barBg)
        barBg.addSubview(barFill)
        breakdownCard.addSubview(dotsContainer)

        breakdownTitleLabel.snp.makeConstraints {
            $0.top.equalTo(statsCard.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        breakdownCard.snp.makeConstraints {
            $0.top.equalTo(breakdownTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        legendRow.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.trailing.equalToSuperview().inset(14)
        }
        barBg.snp.makeConstraints {
            $0.top.equalTo(legendRow.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(14)
            $0.height.equalTo(10)
        }
        barFill.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.equalTo(50)
        }
        dotsContainer.snp.makeConstraints {
            $0.top.equalTo(barBg.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(14)
            $0.bottom.equalToSuperview().offset(-14)
        }

        // Action buttons — pinned to bottom
        addSubview(retryButton)
        retryButton.addSubview(retryIcon)
        retryButton.addSubview(retryLabel)

        let bottomRow = UIStackView(arrangedSubviews: [shareButton, homeButton])
        bottomRow.axis = .horizontal; bottomRow.spacing = 12; bottomRow.distribution = .fillEqually
        addSubview(bottomRow)

        retryButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(bottomRow.snp.top).offset(-12)
            $0.height.equalTo(54)
        }
        retryIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(22)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(18)
        }
        retryLabel.snp.makeConstraints { $0.center.equalToSuperview() }

        bottomRow.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-12)
            $0.height.equalTo(52)
        }

        // Constrain breakdown card top so it doesn't overlap buttons
        breakdownCard.snp.makeConstraints {
            $0.bottom.lessThanOrEqualTo(retryButton.snp.top).offset(-12)
        }
    }

    // MARK: Actions

    @objc private func retryTapped() { onRetry?() }
    @objc private func shareTapped() { onShare?() }
    @objc private func homeTapped()  { onHome?() }
}

// MARK: - Helpers

private func makeLegendLabel() -> UILabel {
    let l = UILabel()
    l.font = .systemFont(ofSize: 12, weight: .regular)
    l.textColor = UIColor(hex: "64748b")
    return l
}

private final class StatColumn: UIView {
    private let emojiLabel  = UILabel()
    private let valueLabel  = UILabel()
    private let descLabel   = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        let sv = UIStackView(arrangedSubviews: [emojiLabel, valueLabel, descLabel])
        sv.axis = .vertical; sv.alignment = .center; sv.spacing = 3
        addSubview(sv)
        sv.snp.makeConstraints { $0.edges.equalToSuperview() }
        emojiLabel.font  = .systemFont(ofSize: 22)
        valueLabel.font  = .systemFont(ofSize: 18, weight: .heavy)
        descLabel.font   = .systemFont(ofSize: 10, weight: .regular)
        descLabel.textColor = UIColor(hex: "94a3b8")
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 2
    }
    required init?(coder: NSCoder) { fatalError() }

    func configure(emoji: String, value: String, label: String, color: UIColor) {
        emojiLabel.text  = emoji
        valueLabel.text  = value
        valueLabel.textColor = color
        descLabel.text   = label
    }
}

private final class LegendDot: UIView {
    init(color: UIColor) {
        super.init(frame: .zero)
        backgroundColor = color
        layer.cornerRadius = 5
        snp.makeConstraints { $0.size.equalTo(10) }
    }
    required init?(coder: NSCoder) { fatalError() }
}

private final class ResultDot: UIView {
    init(correct: Bool) {
        super.init(frame: .zero)
        backgroundColor = correct ? UIColor(hex: "dcfce7") : UIColor(hex: "fee2e2")
        layer.cornerRadius = 9
        let iv = UIImageView(image: UIImage(systemName: correct ? "checkmark" : "xmark"))
        iv.tintColor = correct ? UIColor(hex: "22c55e") : UIColor(hex: "ef4444")
        iv.contentMode = .scaleAspectFit
        addSubview(iv)
        iv.snp.makeConstraints { $0.center.equalToSuperview(); $0.size.equalTo(12) }
        snp.makeConstraints { $0.size.equalTo(28) }
    }
    required init?(coder: NSCoder) { fatalError() }
}

private final class SecondaryButton: UIButton {
    init(icon: String, title: String) {
        super.init(frame: .zero)
        backgroundColor = UIColor(hex: "f1f5f9")
        layer.cornerRadius = 18
        setTitle("  \(title)", for: .normal)
        setTitleColor(UIColor(hex: "0f172a"), for: .normal)
        titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        setImage(UIImage(systemName: icon), for: .normal)
        tintColor = UIColor(hex: "0f172a")
    }
    required init?(coder: NSCoder) { fatalError() }
}
