//
//  HomeViewController.swift
//  DYTV
//
//  Created by gongsheng on 16/11/13.
//  Copyright © 2016年 gongsheng. All rights reserved.
//

import UIKit
private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    //懒加载属性
    fileprivate lazy var pageTieleView : PageTitleView = {[weak self] in
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: frame, titles: titles)
//        titleView.backgroundColor = UIColor.cyan;
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        var childVcs = [UIViewController]()
        let recommend = RecommendViewController()
        recommend.view.backgroundColor = UIColor.cyan
        
        let game = UIViewController()
        game.view.backgroundColor = UIColor.red
        
        let amuse = UIViewController()
        amuse.view.backgroundColor = UIColor.blue
        
        let funny = UIViewController()
        funny.view.backgroundColor = UIColor.purple
        
        childVcs.append(recommend)
        childVcs.append(game)
        childVcs.append(amuse)
        childVcs.append(funny)
        
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH
        
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        
        contentView.delegate = self
        
        return contentView
    }()

    
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
        
        //设置导航栏
        setupNavigationBar()
        
        //添加titleView
        view.addSubview(pageTieleView)
        
        //添加contentView
        view.addSubview(pageContentView)
        
        pageContentView.backgroundColor = UIColor.orange
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


//Mark - 遵守PageTitleViewDelegate 
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectIndex: Int) {
        pageContentView.scrollToIndex(index: selectIndex)
    }
}

extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTieleView.setCurrentTitle(sourceIndex: sourceIndex, targetIndex: targetIndex, progress: progress)
    }
}































