import UIKit
import SnapKit

final class OnboardingPageView: UIView {

    private let illustrationCard: IllustrationCardView
    private let headingLabel = UILabel()
    private let subtitleLabel = UILabel()

    init(model: OnboardingPageModel) {
        illustrationCard = IllustrationCardView(model: model)
        super.init(frame: .zero)
        configure(with: model)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }
}

private extension OnboardingPageView {

    func configure(with model: OnboardingPageModel) {
        backgroundColor = UIColor(hex: "f8fafc")

        headingLabel.text = model.heading
        headingLabel.font = .systemFont(ofSize: 28, weight: .bold)
        headingLabel.textColor = UIColor(hex: "0f172a")
        headingLabel.textAlignment = .center
        headingLabel.numberOfLines = 0

        subtitleLabel.text = model.subtitle
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textColor = UIColor(hex: "64748b")
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
    }

    func setupUI() {
        [illustrationCard, headingLabel, subtitleLabel].forEach { addSubview($0) }
    }

    func setupConstraints() {
        illustrationCard.snp.makeConstraints {
            $0.top.equalToSuperview().offset(98)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(280)
        }
        headingLabel.snp.makeConstraints {
            $0.top.equalTo(illustrationCard.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(headingLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(48)
        }
    }
}

private final class IllustrationCardView: UIView {

    private let gradientLayer = CAGradientLayer()
    private let centerCard = UIView()
    private let centerLabel = UILabel()
    private let model: OnboardingPageModel

    init(model: OnboardingPageModel) {
        self.model = model
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        let cardSize: CGFloat = 120
        centerCard.frame = CGRect(
            x: (bounds.width - cardSize) / 2,
            y: 80,
            width: cardSize,
            height: cardSize
        )
        centerLabel.frame = centerCard.bounds
    }

    private func setupUI() {
        clipsToBounds = true
        layer.cornerRadius = 32

        gradientLayer.colors = model.gradientColors.map(\.cgColor)
        gradientLayer.startPoint = CGPoint(x: 0.188, y: 0.109)
        gradientLayer.endPoint = CGPoint(x: 0.812, y: 0.891)
        layer.insertSublayer(gradientLayer, at: 0)

        buildEmojiGrid()

        centerCard.backgroundColor = .white
        centerCard.layer.cornerRadius = 36
        centerCard.layer.shadowColor = model.centerShadowColor.cgColor
        centerCard.layer.shadowOffset = CGSize(width: 0, height: 16)
        centerCard.layer.shadowRadius = 24
        centerCard.layer.shadowOpacity = 1
        addSubview(centerCard)

        centerLabel.text = model.centerEmoji
        centerLabel.font = .systemFont(ofSize: 60)
        centerLabel.textAlignment = .center
        centerCard.addSubview(centerLabel)
    }

    private func buildEmojiGrid() {
        let xs: [CGFloat] = [24, 68, 112, 156, 200, 244, 288]
        let ys: [CGFloat] = [24, 82, 140]
        for (row, y) in ys.enumerated() {
            for (col, x) in xs.enumerated() {
                let label = UILabel()
                label.text = model.emojiGrid[(row * xs.count + col) % model.emojiGrid.count]
                label.font = .systemFont(ofSize: 28)
                label.alpha = 0.2
                label.frame = CGRect(x: x, y: y, width: 40, height: 40)
                addSubview(label)
            }
        }
    }
}
