import UIKit
import SnapKit

// MARK: - Gradient helper

private final class GradientView: UIView {
    private let layer_ = CAGradientLayer()

    init(start: UIColor, end: UIColor, angle: CGFloat = 0) {
        super.init(frame: .zero)
        layer_.colors = [start.cgColor, end.cgColor]
        let rad = angle * .pi / 180
        let dx = cos(rad + .pi / 2)
        let dy = sin(rad + .pi / 2)
        layer_.startPoint = CGPoint(x: 0.5 - dx / 2, y: 0.5 - dy / 2)
        layer_.endPoint   = CGPoint(x: 0.5 + dx / 2, y: 0.5 + dy / 2)
        layer.insertSublayer(layer_, at: 0)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer_.frame = bounds
    }
}

// MARK: - Answer option button

private final class AnswerOptionView: UIControl {

    private static let letters = ["A", "B", "C", "D"]

    private let badgeContainer = UIView()
    private let badgeLabel = UILabel()
    private let badgeIcon = UIImageView()
    let answerLabel = UILabel()

    let optionIndex: Int

    init(index: Int, text: String) {
        optionIndex = index
        super.init(frame: .zero)
        answerLabel.text = text
        badgeLabel.text = Self.letters[safe: index] ?? String(UnicodeScalar(65 + index)!)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 18
        layer.borderWidth = 2
        layer.borderColor = UIColor(hex: "e2e8f0").cgColor

        badgeContainer.backgroundColor = UIColor(hex: "f1f5f9")
        badgeContainer.layer.cornerRadius = 10
        badgeContainer.isUserInteractionEnabled = false

        badgeLabel.font = .systemFont(ofSize: 13, weight: .bold)
        badgeLabel.textColor = UIColor(hex: "64748b")
        badgeLabel.textAlignment = .center

        badgeIcon.contentMode = .scaleAspectFit
        badgeIcon.tintColor = .white
        badgeIcon.isHidden = true

        answerLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        answerLabel.textColor = UIColor(hex: "0f172a")
        answerLabel.isUserInteractionEnabled = false
    }

    private func setupConstraints() {
        addSubview(badgeContainer)
        badgeContainer.addSubview(badgeLabel)
        badgeContainer.addSubview(badgeIcon)
        addSubview(answerLabel)

        badgeContainer.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(22)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(32)
        }
        badgeLabel.snp.makeConstraints { $0.center.equalToSuperview() }
        badgeIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(16)
        }
        answerLabel.snp.makeConstraints {
            $0.leading.equalTo(badgeContainer.snp.trailing).offset(14)
            $0.trailing.lessThanOrEqualToSuperview().offset(-22)
            $0.centerY.equalToSuperview()
        }
        snp.makeConstraints { $0.height.equalTo(68) }
    }

    // MARK: - State transitions

    func applyDefault() {
        backgroundColor = .white
        layer.borderColor = UIColor(hex: "e2e8f0").cgColor
        badgeContainer.backgroundColor = UIColor(hex: "f1f5f9")
        badgeLabel.textColor = UIColor(hex: "64748b")
        badgeLabel.isHidden = false
        badgeIcon.isHidden = true
        answerLabel.textColor = UIColor(hex: "0f172a")
        isUserInteractionEnabled = true
    }

    func applyCorrect() {
        backgroundColor = UIColor(hex: "dcfce7")
        layer.borderColor = UIColor(hex: "22c55e").cgColor
        badgeContainer.backgroundColor = UIColor(hex: "22c55e")
        badgeLabel.isHidden = true
        badgeIcon.image = UIImage(systemName: "checkmark")
        badgeIcon.isHidden = false
        answerLabel.textColor = UIColor(hex: "15803d")
        isUserInteractionEnabled = false
    }

    func applyWrong() {
        backgroundColor = UIColor(hex: "fee2e2")
        layer.borderColor = UIColor(hex: "ef4444").cgColor
        badgeContainer.backgroundColor = UIColor(hex: "ef4444")
        badgeLabel.isHidden = true
        badgeIcon.image = UIImage(systemName: "xmark")
        badgeIcon.isHidden = false
        answerLabel.textColor = UIColor(hex: "dc2626")
        isUserInteractionEnabled = false
    }

    func applyDimmed() {
        backgroundColor = .white
        layer.borderColor = UIColor(hex: "f1f5f9").cgColor
        badgeContainer.backgroundColor = UIColor(hex: "f1f5f9")
        badgeLabel.textColor = UIColor(hex: "94a3b8")
        badgeLabel.isHidden = false
        badgeIcon.isHidden = true
        answerLabel.textColor = UIColor(hex: "94a3b8")
        isUserInteractionEnabled = false
    }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.98, y: 0.98) : .identity
            }
        }
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

// MARK: - QuizView

final class QuizView: UIView {

    var onAnswerSelected: ((Int) -> Void)?
    var onContinue: (() -> Void)?
    var onClose: (() -> Void)?

    private weak var viewModel: QuizViewModel?

    // MARK: Header
    private let closeButton: UIButton = {
        let b = UIButton(type: .system)
        let cfg = UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold)
        b.setImage(UIImage(systemName: "xmark", withConfiguration: cfg), for: .normal)
        b.tintColor = UIColor(hex: "64748b")
        b.backgroundColor = .white
        b.layer.cornerRadius = 12
        b.layer.shadowColor = UIColor.black.cgColor
        b.layer.shadowOpacity = 0.08
        b.layer.shadowRadius = 4
        b.layer.shadowOffset = CGSize(width: 0, height: 2)
        return b
    }()

    private let questionCountLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .bold)
        l.textColor = UIColor(hex: "64748b")
        l.textAlignment = .center
        return l
    }()

    private let xpBadge = UIView()
    private let xpIconLabel: UILabel = {
        let l = UILabel()
        l.text = "⚡"
        l.font = .systemFont(ofSize: 14)
        return l
    }()
    private let xpValueLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .heavy)
        l.textColor = UIColor(hex: "4f46e5")
        return l
    }()

    // MARK: Progress
    private let progressBg: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "e2e8f0")
        v.layer.cornerRadius = 3
        return v
    }()
    private let progressFill = GradientView(start: UIColor(hex: "4f46e5"), end: UIColor(hex: "7c3aed"))
    private var progressFraction: CGFloat = 0

    // MARK: Timer
    private let timerPill: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 22
        v.layer.borderWidth = 2
        v.layer.borderColor = UIColor(red: 34/255, green: 197/255, blue: 94/255, alpha: 0.19).cgColor
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.08
        v.layer.shadowRadius = 4
        v.layer.shadowOffset = CGSize(width: 0, height: 2)
        return v
    }()
    private let timerIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "clock"))
        iv.tintColor = UIColor(hex: "22c55e")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private let timerLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .heavy)
        l.textColor = UIColor(hex: "22c55e")
        return l
    }()
    private let timerBarBg: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "f1f5f9")
        v.layer.cornerRadius = 2
        return v
    }()
    private let timerBarFill: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(hex: "22c55e")
        v.layer.cornerRadius = 2
        return v
    }()
    private var timerBarFraction: CGFloat = 1

    // MARK: Question card
    private let questionCard: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 24
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.08
        v.layer.shadowRadius = 10
        v.layer.shadowOffset = CGSize(width: 0, height: 4)
        return v
    }()
    private let typeBadge = PaddedLabel()
    private let questionTextLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 19, weight: .bold)
        l.textColor = UIColor(hex: "0f172a")
        l.numberOfLines = 0
        return l
    }()

    // MARK: Answers
    private let answersStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 12
        sv.alignment = .fill
        return sv
    }()
    private var answerButtons: [AnswerOptionView] = []

    // MARK: Feedback sheet
    private let feedbackSheet: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 28
        v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.12
        v.layer.shadowRadius = 20
        v.layer.shadowOffset = CGSize(width: 0, height: -8)
        return v
    }()
    private let sheetDragHandle: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.12)
        v.layer.cornerRadius = 2
        return v
    }()
    private let feedbackIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private let feedbackTitleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 18, weight: .heavy)
        return l
    }()
    private let feedbackXpLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .semibold)
        return l
    }()
    private let explanationCard: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 14
        v.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        return v
    }()
    private let explanationLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = UIColor(hex: "374151")
        return l
    }()
    private let funFactLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.italicSystemFont(ofSize: 13)
        l.textColor = UIColor(hex: "6b7280")
        l.numberOfLines = 0
        return l
    }()
    private let continueButton: UIButton = {
        let b = UIButton(type: .system)
        b.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 16
        return b
    }()

    // MARK: Init

    init(viewModel: QuizViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        loadCurrentQuestion()
        feedbackSheet.transform = CGAffineTransform(translationX: 0, y: 340)
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        let pw = progressBg.bounds.width * max(progressFraction, 0.005)
        progressFill.snp.updateConstraints { $0.width.equalTo(max(pw, 2)) }
        let tw = timerBarBg.bounds.width * max(timerBarFraction, 0)
        timerBarFill.snp.updateConstraints { $0.width.equalTo(max(tw, 2)) }
    }

    // MARK: - Public

    func reset(viewModel newVM: QuizViewModel) {
        viewModel = newVM
        loadCurrentQuestion()
    }

    func loadCurrentQuestion() {
        guard let vm = viewModel else { return }
        let q = vm.currentQuestion
        questionCountLabel.text = "Question \(vm.currentIndex + 1) of \(vm.totalQuestions)"
        xpValueLabel.text = "\(vm.xp)"
        questionTextLabel.text = q.text

        typeBadge.text = q.type.displayTitle
        typeBadge.textColor = q.type.badgeTextColor
        typeBadge.backgroundColor = q.type.badgeBackground

        // Progress bar
        progressFraction = CGFloat(vm.progressFraction)
        setNeedsLayout()

        // Rebuild answer buttons
        answersStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        answerButtons.removeAll()
        for (i, option) in q.options.enumerated() {
            let btn = AnswerOptionView(index: i, text: option)
            btn.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
            answersStack.addArrangedSubview(btn)
            answerButtons.append(btn)
        }

        // Timer
        updateTimer(seconds: 30, progress: 1.0)

        // Hide feedback sheet
        UIView.animate(withDuration: 0.3) {
            self.feedbackSheet.transform = CGAffineTransform(translationX: 0, y: 340)
        }
    }

    func updateTimer(seconds: Int, progress: Float) {
        timerLabel.text = "\(seconds)s"
        timerBarFraction = CGFloat(max(progress, 0))
        setNeedsLayout()

        let color: UIColor = seconds <= 10
            ? UIColor(hex: "ef4444")
            : UIColor(hex: "22c55e")
        timerLabel.textColor = color
        timerIcon.tintColor = color
        timerBarFill.backgroundColor = color
        timerPill.layer.borderColor = color.withAlphaComponent(0.25).cgColor
    }

    func revealAnswer(selectedIndex: Int, isCorrect: Bool) {
        guard let vm = viewModel else { return }
        let correctIndex = vm.currentQuestion.correctIndex

        for btn in answerButtons {
            if btn.optionIndex == selectedIndex && !isCorrect {
                btn.applyWrong()
            } else if btn.optionIndex == correctIndex {
                btn.applyCorrect()
            } else {
                btn.applyDimmed()
            }
        }

        showFeedback(isCorrect: isCorrect)
    }

    // MARK: - Private setup

    private func setupUI() {
        backgroundColor = UIColor(hex: "f8fafc")
        progressFill.layer.cornerRadius = 3
        progressFill.clipsToBounds = true

        xpBadge.backgroundColor = UIColor(hex: "eef2ff")
        xpBadge.layer.cornerRadius = 12

        typeBadge.font = .systemFont(ofSize: 11, weight: .bold)
        typeBadge.contentInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        typeBadge.layer.cornerRadius = 8
        typeBadge.clipsToBounds = true

        let continueIcon = UIImageView(image: UIImage(systemName: "arrow.right"))
        continueIcon.tintColor = .white
        continueIcon.contentMode = .scaleAspectFit
        continueButton.addSubview(continueIcon)
        continueIcon.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-18)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(18)
        }

        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
    }

    private func setupConstraints() {
        // Header
        let xpRow = UIStackView(arrangedSubviews: [xpIconLabel, xpValueLabel])
        xpRow.axis = .horizontal
        xpRow.spacing = 4
        xpRow.alignment = .center
        xpBadge.addSubview(xpRow)

        addSubview(closeButton)
        addSubview(questionCountLabel)
        addSubview(xpBadge)

        closeButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(38)
        }
        questionCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(closeButton)
            $0.centerX.equalToSuperview()
        }
        xpBadge.snp.makeConstraints {
            $0.centerY.equalTo(closeButton)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(33)
        }
        xpRow.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.trailing.equalToSuperview().inset(12)
        }

        // Progress bar
        addSubview(progressBg)
        progressBg.addSubview(progressFill)
        progressBg.snp.makeConstraints {
            $0.top.equalTo(closeButton.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(6)
        }
        progressFill.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.equalTo(2)
        }

        // Timer pill
        addSubview(timerPill)
        timerPill.addSubview(timerIcon)
        timerPill.addSubview(timerLabel)
        timerPill.addSubview(timerBarBg)
        timerBarBg.addSubview(timerBarFill)

        timerPill.snp.makeConstraints {
            $0.top.equalTo(progressBg.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(44)
        }
        timerIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(18)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(14)
        }
        timerLabel.snp.makeConstraints {
            $0.leading.equalTo(timerIcon.snp.trailing).offset(6)
            $0.centerY.equalToSuperview()
        }
        timerBarBg.snp.makeConstraints {
            $0.leading.equalTo(timerLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-18)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(4)
            $0.width.equalTo(64)
        }
        timerBarFill.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.equalTo(64)
        }

        // Question card
        addSubview(questionCard)
        questionCard.addSubview(typeBadge)
        questionCard.addSubview(questionTextLabel)

        questionCard.snp.makeConstraints {
            $0.top.equalTo(timerPill.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        typeBadge.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(24)
        }
        questionTextLabel.snp.makeConstraints {
            $0.top.equalTo(typeBadge.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-24)
        }

        // Answers
        addSubview(answersStack)
        answersStack.snp.makeConstraints {
            $0.top.equalTo(questionCard.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        // Feedback sheet
        addSubview(feedbackSheet)
        feedbackSheet.addSubview(sheetDragHandle)
        feedbackSheet.addSubview(feedbackIcon)
        feedbackSheet.addSubview(feedbackTitleLabel)
        feedbackSheet.addSubview(feedbackXpLabel)
        feedbackSheet.addSubview(explanationCard)
        explanationCard.addSubview(explanationLabel)
        explanationCard.addSubview(funFactLabel)
        feedbackSheet.addSubview(continueButton)

        feedbackSheet.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(330)
        }
        sheetDragHandle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(36)
            $0.height.equalTo(4)
        }
        feedbackIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36)
            $0.leading.equalToSuperview().offset(24)
            $0.size.equalTo(28)
        }
        feedbackTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(feedbackIcon.snp.trailing).offset(12)
            $0.top.equalTo(feedbackIcon)
            $0.trailing.lessThanOrEqualToSuperview().offset(-24)
        }
        feedbackXpLabel.snp.makeConstraints {
            $0.leading.equalTo(feedbackTitleLabel)
            $0.top.equalTo(feedbackTitleLabel.snp.bottom).offset(2)
        }
        explanationCard.snp.makeConstraints {
            $0.top.equalTo(feedbackIcon.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        explanationLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(14)
        }
        funFactLabel.snp.makeConstraints {
            $0.top.equalTo(explanationLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(14)
            $0.bottom.equalToSuperview().offset(-14)
        }
        continueButton.snp.makeConstraints {
            $0.top.equalTo(explanationCard.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
            $0.bottom.lessThanOrEqualTo(safeAreaLayoutGuide).offset(-12)
        }
    }

    // MARK: - Feedback display

    private func showFeedback(isCorrect: Bool) {
        guard let vm = viewModel else { return }
        let q = vm.currentQuestion

        if isCorrect {
            feedbackSheet.backgroundColor = UIColor(hex: "dcfce7")
            feedbackIcon.image = UIImage(systemName: "checkmark.circle.fill")
            feedbackIcon.tintColor = UIColor(hex: "22c55e")
            feedbackTitleLabel.text = "Correct! 🎉"
            feedbackTitleLabel.textColor = UIColor(hex: "15803d")
            feedbackXpLabel.text = "+100 XP earned"
            feedbackXpLabel.textColor = UIColor(hex: "16a34a")
            feedbackXpLabel.isHidden = false
            continueButton.backgroundColor = UIColor(hex: "22c55e")
            continueButton.setTitle("Continue  ", for: .normal)
        } else {
            feedbackSheet.backgroundColor = UIColor(hex: "fee2e2")
            feedbackIcon.image = UIImage(systemName: "xmark.circle.fill")
            feedbackIcon.tintColor = UIColor(hex: "ef4444")
            feedbackTitleLabel.text = "Not quite! 😅"
            feedbackTitleLabel.textColor = UIColor(hex: "dc2626")
            feedbackXpLabel.isHidden = true
            continueButton.backgroundColor = UIColor(hex: "ef4444")
            continueButton.setTitle("Continue  ", for: .normal)
        }

        let boldAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .bold),
            .foregroundColor: UIColor(hex: "374151")
        ]
        let regularAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor(hex: "374151")
        ]
        let attrStr = NSMutableAttributedString(string: "Explanation: ", attributes: boldAttrs)
        attrStr.append(NSAttributedString(string: q.explanation, attributes: regularAttrs))
        explanationLabel.attributedText = attrStr
        funFactLabel.text = q.funFact

        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.5) {
            self.feedbackSheet.transform = .identity
        }
    }

    // MARK: - Actions

    @objc private func answerTapped(_ sender: AnswerOptionView) {
        answerButtons.forEach { $0.isUserInteractionEnabled = false }
        onAnswerSelected?(sender.optionIndex)
    }

    @objc private func closeTapped() {
        onClose?()
    }

    @objc private func continueTapped() {
        onContinue?()
    }
}

// MARK: - PaddedLabel

final class PaddedLabel: UILabel {
    var contentInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: contentInsets))
    }
    override var intrinsicContentSize: CGSize {
        let s = super.intrinsicContentSize
        return CGSize(
            width: s.width + contentInsets.left + contentInsets.right,
            height: s.height + contentInsets.top + contentInsets.bottom
        )
    }
}
