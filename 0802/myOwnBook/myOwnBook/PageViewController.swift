//
//  PageViewController.swift
//  myOwnBook
//
//  Created by chang on 2017/8/2.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {

    //紀錄內容頁面的類別實體
    var contentViewController:ContentViewController!
    //頁碼計數器
    var pageCounter = 0
    //總頁數(計數不包含封面頁)
    var totalPages = 5
    
    //增加timer宣告(自動翻頁用)
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        //初始化內容頁面
        self.contentViewController = self.storyboard!.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        //傳遞頁碼到內容頁面
        contentViewController.currentPage = pageCounter
        //讓頁面控制器目前管理的頁面
        self.setViewControllers([contentViewController], direction: .forward, animated: false, completion: nil)
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { (timer) in
            //自動往後翻頁
            if self.pageCounter < self.totalPages{
                self.pageCounter += 1
            }else{
                self.pageCounter = 0
            }
            self.contentViewController = self.storyboard!.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
            self.contentViewController.currentPage = self.pageCounter
            self.setViewControllers([self.contentViewController], direction: .forward, animated: true, completion: nil)
        })
    }
    
    //MARK: UIPageViewControllerDataSource
    //往前翻頁
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if pageCounter > 0 {
            pageCounter -= 1
        }else{
            pageCounter = totalPages
        }
        //產生下一頁的頁面
        self.contentViewController = self.storyboard!.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        contentViewController.currentPage = pageCounter
        return contentViewController
    }
    
    //往後翻頁
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if pageCounter < totalPages{
            pageCounter += 1
        }else{
            pageCounter = 0
        }
        self.contentViewController = self.storyboard!.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        contentViewController.currentPage = pageCounter
        return contentViewController
    }
    //MARK: UIPageViewControllerDelegate
    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        return .min //翻轉軸心在右側
    }
    



}
