import UIKit

extension UIView {
    static var identifier: String {
        String(describing: self)
    }
}

// MARK: - Анимация нажатия кнопки как системной
extension UIView {
    func makeSystem(_ button: UIButton) {
        button.addTarget(self, action: #selector(handleIn), for: [
            .touchDown,
            .touchDragInside
        ])
        button.addTarget(self, action: #selector(handleOut), for: [
            .touchUpInside,
            .touchDragOutside,
            .touchUpOutside,
            .touchDragExit,
            .touchCancel
        ])
    }

    @objc func handleIn() {
        UIView.animate(withDuration: 0.45) { self.alpha = 0.55 }
    }

    @objc func handleOut() {
        UIView.animate(withDuration: 0.45) { self.alpha = 1 }
    }
}
