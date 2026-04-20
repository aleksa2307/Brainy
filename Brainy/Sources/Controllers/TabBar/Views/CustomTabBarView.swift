import UIKit
import SnapKit

enum TabBarItem: Int, CaseIterable {
    case home, explore, challenges, ranks, profile

    var title: String {
        switch self {
        case .home: return "Home"
        case .explore: return "Explore"
        case .challenges: return "Challenges"
        case .ranks: return "Ranks"
        case .profile: return "Profile"
        }
    }

    var icon: UIImage? {
        switch self {
        case .home: return UIImage(systemName: "house.fill")
        case .explore: return UIImage(systemName: "safari")
        case .challenges: return UIImage(systemName: "bolt")
        case .ranks: return UIImage(systemName: "chart.bar")
        case .profile: return UIImage(systemName: "person")
        }
    }
}

private final class TabBarItemView: UIView {
    let item: TabBarItem
    var onTap: (() -> Void)?

    private let indicator = UIView()
    private let iconView = UIImageView()
    private let label = UILabel()

    private static let activeColor = UIColor(hex: "4F46E5")
    private static let inactiveColor = UIColor(hex: "94A3B8")

    init(item: TabBarItem) {
        self.item = item
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
    }

    required init?(coder: NSCoder) { fatalError() }

    func setActive(_ active: Bool) {
        let color = active ? Self.activeColor : Self.inactiveColor
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.iconView.tintColor = color
            self.label.textColor = color
        }
        label.font = .systemFont(ofSize: 10, weight: active ? .bold : .medium)
        indicator.isHidden = !active

        if active {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8) {
                self.iconView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
            } completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    self.iconView.transform = .identity
                }
            }
        }
    }

    @objc private func didTap() { onTap?() }
}

private extension TabBarItemView {
    func setupUI() {
        indicator.backgroundColor = UIColor(hex: "4F46E5")
        indicator.layer.cornerRadius = 1.5
        indicator.isHidden = true

        iconView.contentMode = .scaleAspectFit
        iconView.image = item.icon
        iconView.tintColor = Self.inactiveColor

        label.text = item.title
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textColor = Self.inactiveColor
        label.textAlignment = .center
    }

    func setupConstraints() {
        [indicator, iconView, label].forEach { addSubview($0) }

        indicator.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.width.equalTo(32)
            $0.height.equalTo(3)
        }

        iconView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(13)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(26)
        }

        label.snp.makeConstraints {
            $0.top.equalTo(iconView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
    }
}

final class CustomTabBarView: UIView {
    var onTabSelected: ((TabBarItem) -> Void)?

    private let topBorder = UIView()
    private let stackView = UIStackView()
    private var itemViews: [TabBarItemView] = []

    private(set) var selectedItem: TabBarItem = .home

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        select(.home)
    }

    required init?(coder: NSCoder) { fatalError() }

    func select(_ item: TabBarItem) {
        selectedItem = item
        itemViews.forEach { $0.setActive($0.item == item) }
        itemViews.forEach { $0.isUserInteractionEnabled = $0.item != item }
    }
}

private extension CustomTabBarView {
    func setupUI() {
        backgroundColor = UIColor(white: 1, alpha: 0.95)

        topBorder.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08)

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        itemViews = TabBarItem.allCases.map { item in
            let view = TabBarItemView(item: item)
            view.onTap = { [weak self] in
                self?.select(item)
                self?.onTabSelected?(item)
            }
            return view
        }
        itemViews.forEach { stackView.addArrangedSubview($0) }
    }

    func setupConstraints() {
        [topBorder, stackView].forEach { addSubview($0) }

        topBorder.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(topBorder.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(62)
            $0.bottom.equalToSuperview()
        }
    }
}
