public extension UIFont {
    static func ultraLightFont(ofSize size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: .ultraLight)
    }

    static func lightFont(ofSize size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: .light)
    }

    static func regularFont(ofSize size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: .medium)
    }

    static func mediumFont(ofSize size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: .medium)
    }

    static func semiboldFont(ofSize size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: .semibold)
    }

    static func boldFont(ofSize size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: .bold)
    }

    static func blackFont(ofSize size: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: size.rawValue, weight: .black)
    }
}

public enum FontSize: CGFloat {
    case xs = 10.0
    case s = 12.0
    case m = 14.0
    case l = 16.0
    case xl = 18.0
    case xxl = 20.0
}

public extension Optional where Wrapped == UIFont {
    var safeUnwrapped: UIFont {
        return self ?? UIFont.systemFont(ofSize: 14)
    }
}
