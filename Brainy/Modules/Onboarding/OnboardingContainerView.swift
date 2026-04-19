import UIKit
import SnapKit

final class OnboardingContainerView: UIView {

    var onSkip: (() -> Void)?
    var onAction: (() -> Void)?

    let pageContainerView = UIView()

    private let skipButton = UIButton(type: .system)
    private let dotsView = OnboardingDotsView()
    private let actionButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    func updateForPage(_ model: OnboardingPageModel) {
        dotsView.update(activeIndex: model.pageIndex, accentColor: model.accentColor)

        let title = model.buttonTitle
        let showArrow = model.showArrow
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString(
            title,
            attributes: AttributeContainer([
                .font: UIFont.systemFont(ofSize: 17, weight: .bold),
                .foregroundColor: UIColor.white
            ])
        )
        if showArrow {
            config.image = UIImage(
                systemName: "chevron.right",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 13, weight: .bold)
            )
            config.imagePlacement = .trailing
            config.imagePadding = 6
            config.baseForegroundColor = .white
        } else {
            config.image = nil
        }
        actionButton.configuration = config

        UIView.animate(withDuration: 0.25) {
            self.actionButton.backgroundColor = model.accentColor
            self.actionButton.layer.shadowColor = model.accentColor.cgColor
        }
    }
}

// MARK: - Private Setup

private extension OnboardingContainerView {

    func setupUI() {
        backgroundColor = UIColor(hex: "f8fafc")

        skipButton.setTitle("Skip", for: .normal)
        skipButton.setTitleColor(UIColor(hex: "94a3b8"), for: .normal)
        skipButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)

        actionButton.layer.cornerRadius = 18
        actionButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        actionButton.layer.shadowRadius = 12
        actionButton.layer.shadowOpacity = 0.31
        actionButton.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)

        [pageContainerView, skipButton, dotsView, actionButton].forEach { addSubview($0) }
    }

    func setupConstraints() {
        pageContainerView.snp.makeConstraints { $0.edges.equalToSuperview() }

        skipButton.snp.makeConstraints {
            $0.top.equalTo(safeTop)
            $0.trailing.equalToSuperview().inset(24)
        }

        actionButton.snp.makeConstraints {
            $0.bottom.equalTo(safeBottom)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }

        dotsView.snp.makeConstraints {
            $0.bottom.equalTo(actionButton.snp.top).offset(-32)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(8)
        }
    }

    @objc func skipTapped() { onSkip?() }
    @objc func actionTapped() { onAction?() }
}

// MARK: - OnboardingDotsView

private final class OnboardingDotsView: UIView {

    private let stack = UIStackView()
    private var dotViews: [UIView] = []
    private var widthConstraints: [Constraint] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        addSubview(stack)
        stack.snp.makeConstraints { $0.edges.equalToSuperview() }

        for _ in 0..<3 {
            let dot = UIView()
            dot.backgroundColor = UIColor(hex: "cbd5e1")
            dot.layer.cornerRadius = 4
            stack.addArrangedSubview(dot)
            dot.snp.makeConstraints { make in
                make.height.equalTo(8)
                widthConstraints.append(make.width.equalTo(8).constraint)
            }
            dotViews.append(dot)
        }

        update(activeIndex: 0, accentColor: UIColor(hex: "4f46e5"))
    }

    required init?(coder: NSCoder) { fatalError() }

    func update(activeIndex: Int, accentColor: UIColor) {
        let inactive = UIColor(hex: "cbd5e1")
        for (i, dot) in dotViews.enumerated() {
            let isActive = i == activeIndex
            widthConstraints[i].update(offset: isActive ? 24 : 8)
            UIView.animate(withDuration: 0.25) {
                dot.backgroundColor = isActive ? accentColor : inactive
                self.stack.layoutIfNeeded()
            }
        }
    }
}
