//
//  MXAutoPageControl.swift
//  MXPageControl
//
//  Created by Ashbringer on 7/31/15.
//  Copyright (c) 2015 Dian.fm. All rights reserved.
//

import UIKit

class MXAutoPageControl: UIPageControl {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    private var AutoPageControlContext = UInt8()
    
    var scrollView: UIScrollView!
    var interactEnabled: Bool!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, aScrollView : UIScrollView, isInteractEnabled: Bool = false) {
        super.init(frame: frame)
        scrollView = aScrollView
        addObservers()
        
        interactEnabled = isInteractEnabled
        if isInteractEnabled {
            self.addTarget(self, action: "calculateScrollViewContentOffset", forControlEvents: .TouchUpInside)
        }
        
        self.numberOfPages = calculateNumberOfPages()
        self.currentPage = calculateCurrentIndex()
    }
    
    deinit {
        removeObservers()
    }
    
    // MARK: - Observer
    
    func addObservers()
    {
        scrollView.addObserver(self, forKeyPath: "contentOffset", options: .New | .Old, context: &AutoPageControlContext)
        scrollView.addObserver(self, forKeyPath: "contentSize", options: .New | .Old, context: &AutoPageControlContext)
    }
    
    func removeObservers()
    {
        self.removeObserver(self, forKeyPath: "contentOffset", context: &AutoPageControlContext)
        self.removeObserver(self, forKeyPath: "contentSize", context: &AutoPageControlContext)
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if context == &AutoPageControlContext {
            
            switch (keyPath) {
            case "contentOffset":
//                print("contentOffset changed: \(change)")
                if scrollView!.decelerating {
                    self.currentPage = calculateCurrentIndex()
                }
                
            case "contentSize":
//                print("contentSize chagned: \(change[NSKeyValueChangeNewKey])\n")
                self.numberOfPages = calculateNumberOfPages()

            case _:
                assert(false, "unknown key path")
                
            default:
                super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
            }
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    // MARK: - Calculator
    
    func calculateNumberOfPages() -> Int
    {
        return Int(scrollView.contentSize.width / CGRectGetWidth(scrollView.bounds))
    }
    
    func calculateCurrentIndex() -> Int
    {
        return Int(scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds))
    }
    
    func calculateScrollViewContentOffset()
    {
        var offsetX = CGFloat(self.currentPage) * CGRectGetWidth(scrollView.bounds)
        var offsetPoint = CGPointMake(offsetX, 0)
        scrollView.setContentOffset(offsetPoint, animated: true)
    }
}
