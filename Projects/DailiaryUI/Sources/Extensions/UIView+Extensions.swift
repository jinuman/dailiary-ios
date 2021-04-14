public extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            self.addSubview($0)
        }
    }

    func setIsHidden(_ isHidden: Bool, animated: Bool) {
        if animated {
            if self.isHidden, !isHidden {
                self.alpha = 0
                self.isHidden = false
            }
            UIView.animate(
                withDuration: 0.2,
                delay: 0,
                options: .curveEaseInOut,
                animations: {
                    self.alpha = isHidden ? 0 : 1
                },
                completion: { _ in
                    self.isHidden = isHidden
                }
            )
        } else {
            self.isHidden = isHidden
        }
    }
}
