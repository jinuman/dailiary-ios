public extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            self.addArrangedSubview($0)
        }
    }
}
