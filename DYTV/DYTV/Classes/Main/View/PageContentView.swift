//
//  PageContentView.swift
//  DYTV
//
//  Created by gongsheng on 16/11/30.
//  Copyright © 2016年 gongsheng. All rights reserved.
//

import UIKit

private let ContentCellID = "contentCellID"


protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

class PageContentView: UIView {
    
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var isForbidScrollDelegate : Bool = false
    fileprivate var startOffSetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView .register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
        
    }()
    
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


//MARK: - 设置UI界面
extension PageContentView {
    fileprivate func setupUI() {
        //将所有子控制器添加到父控制器当中
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
        //添加UICollectionView, 用于在cell中放置控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view .removeFromSuperview();
        }
        
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffSetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate {return}
        
        //定义需要获取的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        
        let currentOffSetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        //判断是左划还是右划
        if currentOffSetX > startOffSetX {
            //向左滑动
            
            //1.计算progress
            progress = currentOffSetX / scrollViewW - floor(currentOffSetX / scrollViewW)
            
            //2.计算sourceIndex
            sourceIndex = Int(currentOffSetX / scrollViewW)
            
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            //4.如果完全划过去
            if currentOffSetX - startOffSetX == scrollViewW {
                progress = 1;
                targetIndex = sourceIndex
            }
            
        } else {
            //向右滑动
            
            //1.计算progress
            progress = currentOffSetX / scrollViewW - floor(currentOffSetX / scrollViewW)
            progress = 1 - progress;
            
            //2.计算targetIndex
            targetIndex = Int(currentOffSetX / scrollViewW)
            
            //3.计算sourceIndex
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
            //4.如果完全划过去
//            if startOffSetX - currentOffSetX == scrollViewW {
//                progress = 1;
//                targetIndex = sourceIndex
//            }
        }
        
        //通知代理
        
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
}


//MARK: - 对外暴露的方法
extension PageContentView {
    func scrollToIndex(index : Int) {
        
        isForbidScrollDelegate = true
        
        let offSet = CGPoint(x: CGFloat(index) * collectionView.bounds.size.width, y: 0)
        
//        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at:.right, animated: true)
        collectionView.setContentOffset(offSet, animated: false)
    }
}








