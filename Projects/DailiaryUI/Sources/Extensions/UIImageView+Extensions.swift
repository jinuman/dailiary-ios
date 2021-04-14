public extension UIImageView {
    func rotateImage(by degree: CGFloat) {
        let radians = degree * (.pi / 180)
        self.transform = CGAffineTransform(rotationAngle: radians)
    }
}
