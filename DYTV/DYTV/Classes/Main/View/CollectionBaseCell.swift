//
//  CollectionBaseCell.swift
//  DYTV
//
//  Created by gongsheng on 2017/1/10.
//  Copyright © 2017年 gongsheng. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var onlineButton: UIButton!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    //MARK: - 定义模型
    var anchor : AnchorModel? {
        didSet {
            //校验模型是否有值
            guard let anchor = anchor else { return }
            
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineButton.setTitle(onlineStr, for: UIControlState())
            
            //昵称的显示
            nickNameLabel.text = anchor.nickname
            
            //设置封面图片
//            guard let iconURL = URL(string : anchor.vertical_src) else {
//                return
//            }
//            iconImageView
        }
    }
}






