import UIKit
import SnapKit

final class TopBlurView: UIView {

    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    private let gradientMask = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        alpha = 0

        addSubview(blurView)
        blurView.snp.makeConstraints { $0.edges.equalToSuperview() }

        gradientMask.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientMask.locations = [0.55, 1.0]
        layer.mask = gradientMask
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientMask.frame = bounds
    }

    func update(scrollOffset y: CGFloat) {
        alpha = min(y / 30.0, 1.0)
    }
}
