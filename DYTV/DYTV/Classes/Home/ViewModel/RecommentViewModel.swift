//
//  RecommentViewModel.swift
//  DYTV
//
//  Created by gongsheng on 2016/12/17.
//  Copyright © 2016年 gongsheng. All rights reserved.
//

import UIKit

class RecommentViewModel : BaseViewModel{
    //MARK: - 懒加载属性
//    lazy var cycleModels : []
    fileprivate lazy var bigDataGroup : AnchorGroupModel = AnchorGroupModel()
    fileprivate lazy var prettyGroup : AnchorGroupModel = AnchorGroupModel()
    
    
}


//MARK: - 发送网络请求

extension RecommentViewModel {
    func requestData(finishedCallback : @escaping () -> ()) {
        
        //定义参数
//        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        //创建group
        
        
        //1.请求第一部分推荐数据
        NetworkTools.requestData(url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", type: .GET, parameters: ["time" : Date.getCurrentTime()]) { (result) in
            print(result)
            
            //将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            //根据"data"这个key获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //遍历字典数组 转换成模型对象
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            //获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict : dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishedCallback()
        }
        //2.请求第二部分颜值数据
        
        //3.请求后面部分游戏数据
        
        
    }
}
