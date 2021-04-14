public extension UIScrollView {
    func scrollToTop(animated: Bool = true) {
        let topInset = self.contentInset.top
        let leftInset = self.contentInset.left
        self.setContentOffset(
            CGPoint(x: -leftInset, y: -topInset),
            animated: animated
        )
    }
}

public extension UITableView {
    /**
     Multiple `UITableViewCell`s can be registered at once.
     */
    func register(_ cellTypes: [UITableViewCell.Type]) {
        for cellType in cellTypes {
            register(cellType, forCellReuseIdentifier: "\(cellType.self)")
        }
    }

    func dequeueReusableCell<T: UITableViewCell>(
        cellType: T.Type,
        for indexPath: IndexPath
    ) -> T {
        return dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as? T ?? T()
    }
}
