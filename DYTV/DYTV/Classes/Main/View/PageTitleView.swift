//
//  PageTitleView.swift
//  DYTV
//
//  Created by gongsheng on 16/11/27.
//  Copyright © 2016年 gongsheng. All rights reserved.
//

import UIKit

//MARK:- 定义常量
private let kScrollLineH : CGFloat = 2
private let kSelectTitleColor = UIColor(r: 255, g: 128, b: 0, a: 1)
private let kNormalTitleColor = UIColor(r: 85, g: 85, b: 85, a: 1)

private let kNormalRGB : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectRGB : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

private let kDeltaRGB = (kSelectRGB.0 - kNormalRGB.0, kSelectRGB.1 - kNormalRGB.1, kSelectRGB.2 - kNormalRGB.2)

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectIndex : Int)
}


class PageTitleView: UIView {
    
    //MARK:- 定义属性
    
    //标题数组
    fileprivate var titles : [String]
    fileprivate var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    
    //懒加载
    fileprivate lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false;
        scrollView.bounces = false;
        return scrollView;
    }()
    
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = kSelectTitleColor
        
        return scrollLine
    }()
    
    fileprivate lazy var titleLables : [UILabel] = [UILabel]()
    
    
    init(frame: CGRect, titles : [String]) {
        self.titles = titles;
        super.init(frame: frame);
        
        //设置UI
        setupUI()
        
    }
    //自定义构造函数 需要重写init?(coder aDecoder: NSCoder)函数
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not be implemented")
    }

}


extension PageTitleView {
    fileprivate func setupUI() {
        
        //添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds;
        
        //添加title对应的label
        setupTitleLables()
        
        //设置底线和滚动的滑块
        setupBottomLineAndScrollLine()

    }
    
    
    private func setupTitleLables() {
        
        let w : CGFloat = frame.width / CGFloat(titles.count)
        let h : CGFloat = frame.height - kScrollLineH
        let y : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //创建label
            let lable = UILabel()
            
            //设置属性
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.textColor = kNormalTitleColor
            lable.textAlignment = .center
            
            //设置lable的frame
            let x : CGFloat = w * CGFloat(index)
            
            
            lable.frame = CGRect(x: x, y: y, width: w, height: h)
            
            addSubview(lable)
            titleLables.append(lable)
            
            //给label添加手势
            lable.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLableClicked(_:)))
            lable.addGestureRecognizer(tapGes)
            
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        //添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        
        addSubview(bottomLine)
        
        //添加scrollLine
        scrollView.addSubview(scrollLine)
        
        //获取第一个label
        guard let firstLabel = titleLables.first else { return }
        firstLabel.textColor = UIColor.orange
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

extension PageTitleView {
    @objc fileprivate func titleLableClicked(_ tapGes : UITapGestureRecognizer) {
        
        guard let view = tapGes.view else {
            return
        }
        
        let index = view.tag
        
        scrollToIndex(index: index)
    }
    
    private func scrollToIndex(index : Int) {
        let newLabel = titleLables[index]
        let oldLabel = titleLables[currentIndex]
        
        //设置lable的颜色
        newLabel.textColor = kSelectTitleColor
        oldLabel.textColor = kNormalTitleColor
        
        //scrollLine滚动到正确位置
        let scrollLineEndX = scrollLine.frame.width * CGFloat(index)
        
        UIView.animate(withDuration: 0.5) { 
            self.scrollLine.frame.origin.x = scrollLineEndX
        }
        
        //记录index
        currentIndex = index;
        
        //通知代理
        delegate?.pageTitleView(titleView: self, selectIndex: index)
        
        
    }
    
}


//MARK:- 对外暴露方法
extension PageTitleView {
    func setCurrentTitle(sourceIndex : Int, targetIndex : Int, progress : CGFloat) {
        //取出两个label
        let sourceLabel = titleLables[sourceIndex]
        let targetLabel = titleLables[targetIndex]
        
        //移动scrolLline
        let moveMargin = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveMargin * progress
        
        
        //颜色渐变
        sourceLabel.textColor = UIColor(r: kSelectRGB.0 - kDeltaRGB.0 * progress, g: kSelectRGB.1 - kDeltaRGB.1 * progress, b: kSelectRGB.2 - kDeltaRGB.2 * progress, a: 1)
        targetLabel.textColor = UIColor(r: kNormalRGB.0 + kDeltaRGB.0 * progress, g: kNormalRGB.1 + kDeltaRGB.1 * progress, b: kNormalRGB.2 + kDeltaRGB.2 * progress, a: 1)
        
        currentIndex = targetIndex;
        
    }
}












