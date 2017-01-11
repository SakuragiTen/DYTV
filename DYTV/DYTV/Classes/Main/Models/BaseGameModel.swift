//
//  BaseGameModel.swift
//  testCocopods
//
//  Created by gongsheng on 2017/1/9.
//  Copyright © 2017年 com.gongsheng. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    var tag_name : String = ""
    var icon_url : String = ""
    
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValuesForKeys(_ keyedValues: [String : Any]) {
        
    }
}
