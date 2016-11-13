//
//  UIBarButtonItem_Extension.swift
//  DYTV
//
//  Created by gongsheng on 16/11/13.
//  Copyright © 2016年 gongsheng. All rights reserved.
//

import UIKit
extension UIBarButtonItem {
    
    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSize.zero, target : AnyObject? = nil, action : Selector? = nil) {
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        
        if highImageName != "" {
            btn.setImage(UIImage(named : highImageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        if target != nil && action != nil {
            btn.addTarget(target, action: action! , for: .touchUpInside)
        }
        
        
        self.init(customView : btn)
        
    }
    
}
