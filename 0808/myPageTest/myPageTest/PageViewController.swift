//
//  ViewController.swift
//  myPageTest
//
//  Created by chang on 2017/8/8.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    //資料庫連線（從AppDelegate取得）
    var db:OpaquePointer? = nil
    //記錄單一資料行
    var dicRow = [String:String?]()
    //記錄查詢到的資料表（離線資料集）
    var arrTable = [[String:String?]]()
    
    
    
    var contentViewController:ContentViewController!
    //頁碼計數器
    var pageCounter = 0
    //總頁數(計數不包含封面頁)
    var totalPages = 6

    override func viewDidLoad() {
        super.viewDidLoad()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate
        {
            db = appDelegate.getDB()
        }
        getDataFromDB()
        
        self.delegate = self
        self.dataSource = self
        
        //初始化內容頁面
        self.contentViewController = self.storyboard!.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        //傳遞頁碼到內容頁面
        contentViewController.PageVC = self
        //讓頁面控制器目前管理的頁面
        self.setViewControllers([contentViewController], direction: .forward, animated: true, completion: nil)
        self.contentViewController.currentPage = self.pageCounter
        
    }

    //MARK: UIPageViewControllerDataSource
    //往前翻頁
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        if pageCounter > 0 {
            pageCounter -= 1
        }else{
            pageCounter = totalPages
        }
        //產生下一頁的頁面
        self.contentViewController = self.storyboard!.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        contentViewController.currentPage = pageCounter
        contentViewController.PageVC = self
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
        contentViewController.PageVC = self
        return contentViewController
    }
    
    
    
    // MARK: 自定函式
    //讀取資料庫資料
    func getDataFromDB()
    {
        //清除所有的陣列元素
        arrTable.removeAll()        //arrTable = [[String:Any?]]()
        //準備查詢指令
        let sql = "select page,type,title,author,article from poem order by page"
        //將查詢指令轉成c語言的字串
        let cSql = sql.cString(using: .utf8)
        //宣告查詢結果的變數（連線資料集）
        var statement:OpaquePointer? = nil
        //執行查詢指令（-1代表不限定sql指令的長度，最後一個參數為預留參數，目前沒有作用）
        sqlite3_prepare(db, cSql!, -1, &statement, nil)
        //往下讀一筆，如果讀到資料時
        while sqlite3_step(statement) == SQLITE_ROW
        {
            //取得第一個欄位（C語言字串）
            let book_no = sqlite3_column_int(statement, 0)
            //轉換第一個欄位（swift字串）
            let no = String(book_no)
            //print("\(no)")
            
            //取得第二個欄位（C語言字串）
            let book_type = sqlite3_column_text(statement, 1)
            //轉換第二個欄位（swift字串）
            let type = String(cString: book_type!)
            //print("\(type)")
            
            //取得第三個欄位（C語言字串）
            let book_title = sqlite3_column_text(statement, 2)
            //轉換第三個欄位（swift字串）
            let title = String(cString: book_title!)
            //print("\(title)")
            
            //取得第四個欄位（C語言字串）
            let book_author = sqlite3_column_text(statement, 3)
            //轉換第四個欄位（swift字串）
            let author = String(cString: book_author!)
            
            //取得第五個欄位（C語言字串）
            let book_article = sqlite3_column_text(statement, 4)
            //轉換第五個欄位（swift字串）
            let article = String(cString: book_article!)
            
            //根據查詢到的每一個欄位來準備字典
            dicRow = ["no":no,"type":type,"title":title,"author":author,"article":article]
            //將字典加入陣列（離線資料集）
            arrTable.append(dicRow)
        }
        //關閉連線資料集
        sqlite3_finalize(statement)
        
        //print("離線資料集陣列：\(arrTable)")
    }

    
}

