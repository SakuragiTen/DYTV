//
//  MainViewController.swift
//  DYTV
//
//  Created by gongsheng on 16/11/13.
//  Copyright © 2016年 gongsheng. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Follow")
        addChildVc("Profile")
        
    }

    fileprivate func addChildVc(_ storyName : String) {
        
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(childVc)
    }

}
