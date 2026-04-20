import UIKit

final class SplashVC: UIViewController {

    private var splashView: SplashView { view as! SplashView }

    override func loadView() {
        view = SplashView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        splashView.onGetStarted = { [weak self] in self?.showOnboarding() }
        splashView.onSignIn = { [weak self] in self?.showSignIn() }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if AuthManager.shared.isLoggedIn {
            showMainApp()
        } else {
            splashView.playEntranceAnimation()
        }
    }
}

private extension SplashVC {
    func showOnboarding() {
        let vc = OnboardingContainerVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }

    func showSignIn() {
        let vc = LoginVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }

    func showMainApp() {
        let tabBarVC = CustomTabBarViewController()
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.modalTransitionStyle = .crossDissolve
        present(tabBarVC, animated: false)
    }
}
