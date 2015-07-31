//
//  ViewController.swift
//  MXPageControl
//
//  Created by Ashbringer on 7/31/15.
//  Copyright (c) 2015 Dian.fm. All rights reserved.
//

import UIKit

//class MyCollectionViewCell: UICollectionViewCell {
//    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    
//}

class ViewController: UIViewController , UICollectionViewDataSource {

    var collectionView : UICollectionView?
    var dataSourceArray : [UIColor]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        makeData()
        self.view.addSubview(makeCollectionView())
        self.view.addSubview(makeAutoPageControl())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func makeData()
    {
        dataSourceArray = [UIColor]()
        for index in 0...7 {
            dataSourceArray?.append(randomColor())
        }
    }
    
    func randomColor() -> UIColor
    {
        return UIColor(hue: randomNumber(), saturation: randomNumber(), brightness: 1, alpha: 1)
    }
    
    func randomNumber() -> CGFloat
    {
        return CGFloat((CGFloat(arc4random()) % 255) / 255)
    }
    
    func makeCollectionView() -> UICollectionView
    {
        var frame = self.view.frame
        frame.origin = CGPointZero
        frame.size.height = 400;
        collectionView = UICollectionView(frame: frame, collectionViewLayout: makeCollectionViewLayout())
        collectionView?.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        collectionView?.dataSource = self
        collectionView?.pagingEnabled = true
        return collectionView!
    }
    
    func makeCollectionViewLayout() -> UICollectionViewFlowLayout
    {
        var layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = self.view.frame.size
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        return layout
    }
    
    func makeAutoPageControl() -> MXAutoPageControl
    {
        var frame = CGRectMake(100, 500, 200, 20)
        var pageControl = MXAutoPageControl(frame: frame, aScrollView: collectionView!, isInteractEnabled: true)
        pageControl.backgroundColor = UIColor.redColor()
        return pageControl
    }
    
    // MARK: - UICollectionView dataSource & delegate
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceArray!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        cell.contentView.backgroundColor = dataSourceArray?[indexPath.row]
        
        return cell
    }
}

