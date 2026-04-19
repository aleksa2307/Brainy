import UIKit
import SnapKit

final class ExploreViewController: UIViewController {
    private var exploreView: ExploreView {
        return view as! ExploreView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = ExploreView()
    }
}

private extension ExploreViewController {
    
}
