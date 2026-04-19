import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    
    private var homeView: HomeView {
        return view as! HomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = HomeView()
    }
}

private extension HomeViewController {
    
}
