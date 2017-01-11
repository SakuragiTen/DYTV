//
//  BaseViewModel.swift
//  testCocopods
//
//  Created by gongsheng on 2017/1/9.
//  Copyright © 2017年 com.gongsheng. All rights reserved.
//

import UIKit

class BaseViewModel: NSObject {
    lazy var anchorGroups : [AnchorGroupModel] = [AnchorGroupModel]()
}


extension BaseViewModel {
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(url: URLString, type: .GET, parameters: parameters as! [String : NSString]?) { (result) in
            //1.对界面进行处理
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
//             = resultDict["data"] as? [String : Any]
            //判断是否是分组数据
            if isGroupData {
                //2.1 遍历数组中的字典
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroupModel(dict: dict))
                }
            } else {
                let group = AnchorGroupModel()
                
                //遍历dataArray的所有的字典
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict : dict))
                }
                
                //将group添加到anchorGroups
                self.anchorGroups.append(group)
            }
            
            finishedCallback()
            
        }
    }
}
