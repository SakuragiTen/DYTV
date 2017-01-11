//
//  CollectionNormalCell.swift
//  DYTV
//
//  Created by gongsheng on 16/12/11.
//  Copyright © 2016年 gongsheng. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    //MARK: - 控件的属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    //MARK: - 定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
