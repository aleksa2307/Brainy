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
        splashView.playEntranceAnimation()
    }
}

// MARK: - Navigation

private extension SplashVC {

    func showOnboarding() {
        let vc = OnboardingContainerVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

    func showSignIn() {
        // TODO: sign in flow
    }
}
