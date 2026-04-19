import UIKit
import SnapKit

final class CustomTabBarViewController: UIViewController {

    private let tabBarView = CustomTabBarView()
    private var contentControllers: [TabBarItem: UIViewController] = [:]
    private var activeController: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupTabBar()
        registerControllers()
        switchTo(.home)
    }
}

// MARK: - Private

private extension CustomTabBarViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
    }

    func setupConstraints() {
        view.addSubview(tabBarView)

        tabBarView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    func registerControllers() {
        contentControllers = [
            .home: HomeViewController(),
            .explore: ExploreViewController(),
            .challenges: ChallengesViewController(),
            .ranks: UIViewController(),
            .profile: ProfileViewController()
        ]
    }

    func setupTabBar() {
        tabBarView.onTabSelected = { [weak self] item in
            self?.switchTo(item)
        }
    }

    func switchTo(_ item: TabBarItem) {
        activeController?.willMove(toParent: nil)
        activeController?.view.removeFromSuperview()
        activeController?.removeFromParent()

        guard let vc = contentControllers[item] else { return }

        addChild(vc)
        view.insertSubview(vc.view, belowSubview: tabBarView)

        vc.view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(tabBarView.snp.top)
        }

        vc.didMove(toParent: self)
        activeController = vc
    }
}
