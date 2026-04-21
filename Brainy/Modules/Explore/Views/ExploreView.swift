import UIKit
import SnapKit

final class ExploreView: UIView, UITextFieldDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate {

    private weak var viewModel: ExploreViewModel?

    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()
    private let topBlur = TopBlurView()
    private let titleLabel = UILabel()
    private let searchField = UITextField()
    private let categoryScroll = UIScrollView()
    private let categoryStack = UIStackView()
    private let resultsLabel = UILabel()
    private let cardsStack = UIStackView()

    private var categoryButtons: [UIButton] = []

    init(viewModel: ExploreViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        reloadFromViewModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var onQuizSelected: ((ExploreQuizItem) -> Void)?

    func reloadFromViewModel() {
        guard let viewModel else { return }
        resultsLabel.text = viewModel.resultsCountText
        updateCategorySelection(selectedIndex: viewModel.selectedCategoryIndex)
        cardsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for item in viewModel.filteredQuizzes {
            let card = ExploreQuizCardView()
            card.configure(with: item)
            card.onTap = { [weak self] in self?.onQuizSelected?(item) }
            cardsStack.addArrangedSubview(card)
        }
    }
}

private extension ExploreView {
    func setupUI() {
        backgroundColor = UIColor(hex: "f8fafc")

        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false

        contentStack.axis = .vertical
        contentStack.spacing = 16
        contentStack.alignment = .fill
        
        titleLabel.text = "Explore"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = UIColor(hex: "0f172a")

        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 16
        searchField.layer.borderWidth = 1.5
        searchField.layer.borderColor = UIColor(hex: "e2e8f0").cgColor
        searchField.font = .systemFont(ofSize: 15, weight: .regular)
        searchField.textColor = UIColor(hex: "0f172a")
        searchField.attributedPlaceholder = NSAttributedString(
            string: "Search quizzes, categories...",
            attributes: [
                .foregroundColor: UIColor(hex: "0f172a").withAlphaComponent(0.5),
                .font: UIFont.systemFont(ofSize: 15, weight: .regular)
            ]
        )
        let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchIcon.tintColor = UIColor(hex: "94a3b8")
        searchIcon.contentMode = .scaleAspectFit
        let leftWrap = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 48))
        searchIcon.frame = CGRect(x: 17, y: 15, width: 18, height: 18)
        leftWrap.addSubview(searchIcon)
        searchField.leftView = leftWrap
        searchField.leftViewMode = .always
        searchField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        searchField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        searchField.returnKeyType = .search
        searchField.autocorrectionType = .no
        searchField.delegate = self
        searchField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)

        let tapOutside = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapOutside.cancelsTouchesInView = false
        tapOutside.delegate = self
        scrollView.addGestureRecognizer(tapOutside)

        categoryScroll.showsHorizontalScrollIndicator = false
        categoryStack.axis = .horizontal
        categoryStack.spacing = 8
        categoryStack.alignment = .center

        resultsLabel.font = .systemFont(ofSize: 13, weight: .regular)
        resultsLabel.textColor = UIColor(hex: "94a3b8")

        cardsStack.axis = .vertical
        cardsStack.spacing = 12
        cardsStack.alignment = .fill

        rebuildCategoryChips()
    }

    func setupConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(contentStack)
        scrollView.addSubview(categoryScroll)

        scrollView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        contentStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }

        contentStack.addArrangedSubview(titleLabel)
        contentStack.setCustomSpacing(16, after: titleLabel)

        contentStack.addArrangedSubview(searchField)
        // 16 (gap above) + 44 (category scroll height) + 12 (gap below) = 72
        contentStack.setCustomSpacing(72, after: searchField)

        contentStack.addArrangedSubview(resultsLabel)
        contentStack.setCustomSpacing(12, after: resultsLabel)
        contentStack.addArrangedSubview(cardsStack)

        contentStack.layoutMargins = UIEdgeInsets(top: 12, left: 24, bottom: 24, right: 24)
        contentStack.isLayoutMarginsRelativeArrangement = true

        categoryScroll.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        categoryScroll.addSubview(categoryStack)
        categoryScroll.snp.makeConstraints {
            $0.top.equalTo(searchField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        categoryStack.snp.makeConstraints {
            $0.edges.equalTo(categoryScroll.contentLayoutGuide)
            $0.height.equalTo(36)
        }

        addSubview(topBlur)
        topBlur.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.top).offset(64)
        }
        scrollView.delegate = self
    }

    func rebuildCategoryChips() {
        guard let viewModel else { return }
        categoryStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        categoryButtons.removeAll()

        for (index, title) in viewModel.categories.enumerated() {
            let button = UIButton(type: .system)
            var config = UIButton.Configuration.plain()
            config.title = title
            config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14)
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attrs in
                var updated = attrs
                updated.font = .systemFont(ofSize: 14, weight: .semibold)
                return updated
            }
            button.configuration = config
            button.layer.cornerRadius = 12
            button.tag = index
            button.snp.makeConstraints { $0.height.equalTo(36) }
            button.addTarget(self, action: #selector(categoryTapped(_:)), for: .touchUpInside)
            categoryStack.addArrangedSubview(button)
            categoryButtons.append(button)
        }
        updateCategorySelection(selectedIndex: viewModel.selectedCategoryIndex)
    }

    @objc func categoryTapped(_ sender: UIButton) {
        viewModel?.selectCategory(at: sender.tag)
        reloadFromViewModel()
    }

    func updateCategorySelection(selectedIndex: Int) {
        for (i, button) in categoryButtons.enumerated() {
            let selected = i == selectedIndex
            if selected {
                button.backgroundColor = UIColor(hex: "4f46e5")
                button.configuration?.baseForegroundColor = .white
                button.layer.borderWidth = 0
            } else {
                button.backgroundColor = .white
                button.configuration?.baseForegroundColor = UIColor(hex: "64748b")
                button.layer.borderWidth = 1.5
                button.layer.borderColor = UIColor(hex: "e2e8f0").cgColor
            }
        }
    }

    @objc func searchTextChanged() {
        viewModel?.setSearchQuery(searchField.text ?? "")
        reloadFromViewModel()
    }

    @objc func dismissKeyboard() {
        endEditing(true)
    }
}

extension ExploreView {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let touched = touch.view else { return true }
        if touched === searchField || touched.isDescendant(of: searchField) {
            return false
        }
        return true
    }
}

extension ExploreView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        topBlur.update(scrollOffset: scrollView.contentOffset.y)
    }
}
