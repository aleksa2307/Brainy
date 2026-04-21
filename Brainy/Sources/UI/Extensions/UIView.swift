import UIKit
import SnapKit

extension UIView {
    var safeTop: ConstraintItem { safeAreaLayoutGuide.snp.top }
    var safeBottom: ConstraintItem { safeAreaLayoutGuide.snp.bottom }

    var firstResponder: UIView? {
        guard !isFirstResponder else { return self }
        return subviews.compactMap { $0.firstResponder }.first
    }
}

extension UIViewController {
    func setupKeyboardAvoidance() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(handleKeyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(handleKeyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
}

extension UIViewController {
    @objc func handleKeyboardWillShow(_ notification: Notification) {
        guard
            let info = notification.userInfo,
            let kbFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curveRaw = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }

        let kbTop = view.frame.height - kbFrame.height
        var contentBottom: CGFloat = view.frame.height
        if let responder = view.firstResponder {
            contentBottom = responder.convert(responder.bounds, to: view).maxY + 24
        }
        let overlap = contentBottom - kbTop
        guard overlap > 0 else { return }

        let options = UIView.AnimationOptions(rawValue: curveRaw << 16)
        UIView.animate(withDuration: duration, delay: 0, options: options) {
            self.view.transform = CGAffineTransform(translationX: 0, y: -overlap)
        }
    }

    @objc func handleKeyboardWillHide(_ notification: Notification) {
        guard
            let info = notification.userInfo,
            let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curveRaw = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }

        let options = UIView.AnimationOptions(rawValue: curveRaw << 16)
        UIView.animate(withDuration: duration, delay: 0, options: options) {
            self.view.transform = .identity
        }
    }
}
