//
//  UIKit+DailyJournal.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 5..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

extension UIColor {
    static var mint: UIColor {
        return UIColor(red: 150/255, green: 203/255, blue: 171/255, alpha: 1)
    }
    
    static var gradientStart: UIColor {
        return UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1)
    }
    
    static var gradientEnd: UIColor {
        return UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
    }
}

extension UIImage {
    static func gradientImage(with colors: [UIColor], size:CGSize) -> UIImage? {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
