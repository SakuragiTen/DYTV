//
//  NetworkTools.swift
//  testCocopods
//
//  Created by gongsheng on 2016/12/17.
//  Copyright © 2016年 com.gongsheng. All rights reserved.
//

import UIKit

import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    class func requestData(url : String, type : MethodType, parameters : [String : NSString]? = nil, finishedCallBack : @escaping (_ result : AnyObject) -> ()) {
        
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
     
        
        Alamofire.request(url, method : method, parameters : parameters).responseJSON { (response) in
            guard let results = response.result.value else {
                print(response.result.error)
                return
            }
            finishedCallBack(results as AnyObject)
        }
    }
    
}








