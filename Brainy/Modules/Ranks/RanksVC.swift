import UIKit
import SnapKit

final class RanksViewController: UIViewController {
    
    private var ranksView: RanksView {
        return view as! RanksView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = RanksView()
    }
}

private extension RanksViewController {
    
}
