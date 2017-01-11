//
//  NSDate-Extension.swift
//  DYTV
//
//  Created by gongsheng on 2017/1/10.
//  Copyright © 2017年 gongsheng. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let date = NSDate()
        
        let interval = Int(date.timeIntervalSince1970)
        
        return "\(interval)"
        
    }
}
