# MXAutoPageControl
MXAutoPageControl is a subclass of UIPageControl

It can automatically set the right ``numberOfPages`` and ``currentPage`` depends on the scrollView, and also 

## Introduction

It depends on KVO of scrollView's ``contentOffset`` and ``contentSize``   
Then changes the UIPageControl's property ``numberOfPages`` and ``currentPage``

### Usage

You can easily use it just like a normal UIPageControl
```swift
var frame = CGRectMake(100, 500, 200, 20)
var pageControl = MXAutoPageControl(frame: frame, aScrollView: collectionView!, isInteractEnabled: true)
self.view.addSubView(pageControl)
```

1. You have to set the frame or layout constrains yourself
2. You should pass the scrollView you want this page control interact
3. When ``isInteractEnabled`` is true, tap on the page control will set the scrollView contentOffset.

### To-do
1. It can only handle scrollView scrolls on horizontal. I will make it better use for vertical scrolls.