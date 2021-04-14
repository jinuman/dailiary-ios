public extension UIScrollView {
    func isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        guard self.frame.size.height > 0,
              self.contentSize.height > 0 else { return false }
        return self.contentOffset.y > (self.contentSize.height - self.frame.size.height - edgeOffset)
    }
}

public extension Reactive where Base: UIScrollView {
    var contentSize: ControlEvent<CGSize> {
        let source = base.rx.observe(CGSize.self, "contentSize")
            .asObservable()
            .compactMap { $0 }
        return ControlEvent(events: source)
    }

    var isNearBottomEdge: ControlEvent<Void> {
        let source: Observable<Void> = base.rx.contentOffset
            .map { [weak base = self.base] _ in
                guard let base = base else { return false }
                return base.isNearBottomEdge()
            }
            .filter { $0 }
            .map { _ in () }
        return ControlEvent(events: source)
    }
}
