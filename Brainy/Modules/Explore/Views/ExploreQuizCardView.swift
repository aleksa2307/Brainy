import UIKit
import SnapKit

private final class HorizontalGradientView: UIView {
    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    required init?(coder: NSCoder) { fatalError() }

    func setColors(_ colors: [UIColor]) {
        gradientLayer.colors = colors.map { $0.cgColor }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

private final class DiagonalTintView: UIView {
    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        layer.cornerRadius = 18
        clipsToBounds = true
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    required init?(coder: NSCoder) { fatalError() }

    func setTint(start: UIColor, end: UIColor) {
        gradientLayer.colors = [start.cgColor, end.cgColor]
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}

final class ExploreQuizCardView: UIView {

    var onTap: (() -> Void)?

    private let shadowContainer = UIView()
    private let card = UIView()
    private let topBar = HorizontalGradientView()
    private let rowStack = UIStackView()

    private let thumbnailBackground = DiagonalTintView()
    private let emojiLabel = UILabel()
    private let textColumn = UIStackView()
    private let categoryRow = UIStackView()
    private let categoryLabel = UILabel()
    private let supplementaryBadge = PaddedTagLabel()
    private let titleLabel = UILabel()
    private let metaRow = UIStackView()
    private let favoriteButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        favoriteButton.isHidden = true
        addGestureRecognizer(tap)
    }

    required init?(coder: NSCoder) { fatalError() }

    @objc private func handleTap() { onTap?() }

    func configure(with item: ExploreQuizItem) {
        topBar.setColors([
            UIColor(hex: item.topBarGradientStartHex),
            UIColor(hex: item.topBarGradientEndHex)
        ])

        let s = UIColor(hex: item.thumbnailGradientStartHex).withAlphaComponent(0.125)
        let e = UIColor(hex: item.thumbnailGradientEndHex).withAlphaComponent(0.19)
        thumbnailBackground.setTint(start: s, end: e)

        categoryLabel.text = item.categoryLabel
        categoryLabel.textColor = UIColor(hex: item.categoryLabelColorHex)
        titleLabel.text = item.title
        emojiLabel.text = item.emoji

        applySupplementaryTag(item.supplementaryTag)
        rebuildMetaRow(with: item)
    }

    private func setupUI() {
        shadowContainer.layer.shadowColor = UIColor.black.cgColor
        shadowContainer.layer.shadowOpacity = 0.06
        shadowContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowContainer.layer.shadowRadius = 12
        shadowContainer.layer.cornerRadius = 20

        card.backgroundColor = .white
        card.layer.cornerRadius = 20
        card.clipsToBounds = true

        topBar.setColors([UIColor(hex: "06b6d4"), UIColor(hex: "3b82f6")])

        emojiLabel.font = .systemFont(ofSize: 30)
        emojiLabel.textAlignment = .center

        categoryLabel.font = .systemFont(ofSize: 11, weight: .bold)
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = UIColor(hex: "0f172a")
        titleLabel.numberOfLines = 2

        categoryRow.axis = .horizontal
        categoryRow.alignment = .center
        categoryRow.spacing = 8

        textColumn.axis = .vertical
        textColumn.spacing = 4
        textColumn.alignment = .leading

        metaRow.axis = .horizontal
        metaRow.alignment = .center
        metaRow.spacing = 16
        metaRow.distribution = .fill

        rowStack.axis = .horizontal
        rowStack.alignment = .center
        rowStack.spacing = 16
        rowStack.distribution = .fill
        textColumn.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textColumn.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        favoriteButton.setContentHuggingPriority(.required, for: .horizontal)
        thumbnailBackground.setContentHuggingPriority(.required, for: .horizontal)

        thumbnailBackground.setTint(
            start: UIColor(hex: "06b6d4").withAlphaComponent(0.125),
            end: UIColor(hex: "3b82f6").withAlphaComponent(0.19)
        )

        favoriteButton.backgroundColor = UIColor(hex: "eef2ff")
        favoriteButton.layer.cornerRadius = 10
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.tintColor = UIColor(hex: "6366f1")
        favoriteButton.isUserInteractionEnabled = false
    }

    private func setupConstraints() {
        addSubview(shadowContainer)
        shadowContainer.addSubview(card)

        shadowContainer.snp.makeConstraints { $0.edges.equalToSuperview() }
        card.snp.makeConstraints { $0.edges.equalToSuperview() }

        card.addSubview(topBar)
        topBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(8)
        }

        card.addSubview(rowStack)
        rowStack.snp.makeConstraints {
            $0.top.equalTo(topBar.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }

        rowStack.addArrangedSubview(thumbnailBackground)
        thumbnailBackground.snp.makeConstraints { $0.size.equalTo(60) }
        thumbnailBackground.addSubview(emojiLabel)
        emojiLabel.snp.makeConstraints { $0.center.equalToSuperview() }

        rowStack.addArrangedSubview(textColumn)
        categoryRow.addArrangedSubview(categoryLabel)
        categoryRow.addArrangedSubview(supplementaryBadge)
        categoryRow.addArrangedSubview(UIView())
        textColumn.addArrangedSubview(categoryRow)
        textColumn.addArrangedSubview(titleLabel)
        textColumn.addArrangedSubview(metaRow)

        rowStack.addArrangedSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { $0.size.equalTo(32) }
    }

    private func applySupplementaryTag(_ tag: ExploreQuizItem.SupplementaryTag) {
        switch tag {
        case .none:
            supplementaryBadge.isHidden = true
            supplementaryBadge.text = nil
        case .new:
            supplementaryBadge.isHidden = false
            supplementaryBadge.text = "NEW"
            supplementaryBadge.textColor = UIColor(hex: "16a34a")
            supplementaryBadge.backgroundColor = UIColor(hex: "dcfce7")
            supplementaryBadge.contentInsets = UIEdgeInsets(top: 1, left: 6, bottom: 1, right: 6)
            supplementaryBadge.font = .systemFont(ofSize: 10, weight: .bold)
            supplementaryBadge.layer.cornerRadius = 6
        case .pro:
            supplementaryBadge.isHidden = true
            supplementaryBadge.text = "🔒 PRO"
            supplementaryBadge.textColor = UIColor(hex: "64748b")
            supplementaryBadge.backgroundColor = UIColor(hex: "f1f5f9")
            supplementaryBadge.contentInsets = UIEdgeInsets(top: 1, left: 6, bottom: 1, right: 6)
            supplementaryBadge.font = .systemFont(ofSize: 10, weight: .bold)
            supplementaryBadge.layer.cornerRadius = 6
        }
    } 

    private func rebuildMetaRow(with item: ExploreQuizItem) {
        metaRow.arrangedSubviews.forEach { $0.removeFromSuperview() }

        metaRow.addArrangedSubview(
            metaChip(icon: "star.fill", text: item.rating, iconTint: UIColor(hex: "eab308"), textWeight: .semibold)
        )
        metaRow.addArrangedSubview(
            metaChip(icon: "clock", text: item.duration.replacingOccurrences(of: " ", with: "\n"), iconTint: UIColor(hex: "94a3b8"), textWeight: .regular, multiline: true)
        )
        metaRow.addArrangedSubview(
            metaChip(icon: "person.2.fill", text: item.participants, iconTint: UIColor(hex: "94a3b8"), textWeight: .regular)
        )

        let diff = PaddedTagLabel()
        diff.text = item.difficulty.title
        diff.font = .systemFont(ofSize: 11, weight: .bold)
        diff.textColor = item.difficulty.textColor
        diff.backgroundColor = item.difficulty.backgroundColor
        diff.layer.cornerRadius = 6
        diff.clipsToBounds = true
        diff.contentInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        metaRow.addArrangedSubview(diff)
    }

    private func metaChip(icon: String, text: String, iconTint: UIColor, textWeight: UIFont.Weight, multiline: Bool = false) -> UIView {
        let wrap = UIStackView()
        wrap.axis = .horizontal
        wrap.spacing = 4
        wrap.alignment = .center

        let iv = UIImageView(image: UIImage(systemName: icon))
        iv.tintColor = iconTint
        iv.contentMode = .scaleAspectFit
        iv.snp.makeConstraints { $0.size.equalTo(12) }

        let lab = UILabel()
        lab.text = text
        lab.font = .systemFont(ofSize: 12, weight: textWeight)
        lab.textColor = UIColor(hex: "64748b")
        if multiline {
            lab.numberOfLines = 0
            lab.textAlignment = .center
        }

        wrap.addArrangedSubview(iv)
        wrap.addArrangedSubview(lab)
        return wrap
    }
}

private final class PaddedTagLabel: UILabel {
    var contentInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: contentInsets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + contentInsets.left + contentInsets.right,
            height: size.height + contentInsets.top + contentInsets.bottom
        )
    }
}
