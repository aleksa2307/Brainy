import UIKit

final class OnboardingContainerVC: UIViewController {

    private var containerView: OnboardingContainerView { view as! OnboardingContainerView }

    private let pageVC = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal
    )
    private let pages = OnboardingPageModel.all.map { OnboardingPageVC(model: $0) }
    private var currentIndex = 0

    override func loadView() {
        view = OnboardingContainerView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageVC()
        containerView.onSkip = { [weak self] in self?.finish() }
        containerView.onAction = { [weak self] in self?.handleAction() }
        containerView.updateForPage(pages[0].model)
    }
}

private extension OnboardingContainerVC {

    func setupPageVC() {
        addChild(pageVC)
        containerView.pageContainerView.addSubview(pageVC.view)
        pageVC.view.frame = containerView.pageContainerView.bounds
        pageVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pageVC.view.backgroundColor = .clear
        pageVC.didMove(toParent: self)

        pageVC.dataSource = nil

        pageVC.setViewControllers([pages[0]], direction: .forward, animated: false)
    }

    func handleAction() {
        if currentIndex + 1 < pages.count {
            advance()
        } else {
            finish()
        }
    }

    func advance() {
        currentIndex += 1
        let model = pages[currentIndex].model
        pageVC.setViewControllers([pages[currentIndex]], direction: .forward, animated: true)
        containerView.updateForPage(model)
    }

    func finish() {
        let vc = CreateAccountVC()
        vc.hidesBackButton = true
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
}
