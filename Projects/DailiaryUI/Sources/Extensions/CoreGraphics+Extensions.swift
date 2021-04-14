public extension CGSize {
    init(all: CGFloat) {
        self.init(width: all, height: all)
    }

    init(width: CGFloat) {
        self.init(width: width, height: UIScreen.main.bounds.height)
    }

    init(height: CGFloat) {
        self.init(width: UIScreen.main.bounds.width, height: height)
    }
}
