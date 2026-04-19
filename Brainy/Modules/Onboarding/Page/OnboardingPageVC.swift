import UIKit

final class OnboardingPageVC: UIViewController {

    let model: OnboardingPageModel

    init(model: OnboardingPageModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func loadView() {
        view = OnboardingPageView(model: model)
    }
}
