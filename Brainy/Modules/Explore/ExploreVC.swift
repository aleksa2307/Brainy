import UIKit

final class ExploreViewController: UIViewController {

    private let viewModel = ExploreViewModel()

    override func loadView() {
        view = ExploreView(viewModel: viewModel)
    }
}
