import UIKit
import SnapKit

final class ChallengesViewController: UIViewController {
    private var challengesView: ChallengesView {
        return view as! ChallengesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = ChallengesView()
    }
}

private extension ChallengesViewController {
    
}
