//
//  UIColor-Extension.swift
//  DYTV
//
//  Created by gongsheng on 16/12/10.
//  Copyright © 2016年 gongsheng. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat, a : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    class func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return UIColor(r: r, g: g, b: b, a: 1)
    }
}

