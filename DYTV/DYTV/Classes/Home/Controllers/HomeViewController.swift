//
//  HomeViewController.swift
//  DYTV
//
//  Created by gongsheng on 16/11/13.
//  Copyright © 2016年 gongsheng. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
// MARK: - 设置UI界面
extension HomeViewController {
    fileprivate func setupUI() {
        
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
    }
    
    fileprivate func setupNavigationBar() {
        
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo",  target: self, action: #selector(self.leftItemClicked))
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size, target: self, action: #selector(self.historyItemClicked))
        
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size, target : self, action : #selector(self.seachItemClicked))
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size, target : self, action : #selector(self.qrcodeItemClicked))
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
    
    @objc func leftItemClicked() {
        print("左侧的按钮点击了")
    }
    
    @objc private func historyItemClicked() {
        print("点击历史记录")
    }
    
    @objc func seachItemClicked() {
        print("点击搜索")
    }
    @objc func qrcodeItemClicked() {
        print("点击扫描二维码")
    }
    
}




































