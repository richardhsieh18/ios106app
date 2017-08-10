//
//  ContentViewController.swift
//  myPageTest
//
//  Created by chang on 2017/8/8.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var txtArticle: UITextView!
    @IBOutlet weak var lblPage: UILabel!
    
    //記錄查詢到的資料表（離線資料集）
    //var arrTable = [[String:String?]]()
    
    //紀錄目前頁碼(供pageViewcontroller傳遞頁碼使用)
    var currentPage = 0
    
    var PageVC:PageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        lblTitle.text = PageVC.arrTable[currentPage]["title"]!
        lblAuthor.text = PageVC.arrTable[currentPage]["author"]!
        let fileName = PageVC.arrTable[currentPage]["type"]!
        //print(fileName!)
        imgType.image = UIImage(named: fileName!)
        //txtArticle.text = PageVC.arrTable[currentPage]["article"]!
        lblPage.text = "\(currentPage + 1)"
        
        //設變數含字
        let txtViewText = PageVC.arrTable[currentPage]["article"]!
        
        //初始化段落樣式
        let paragraphStyle = NSMutableParagraphStyle()
        //設定段落樣式的行距 
        paragraphStyle.lineSpacing = 10
        //設定段落樣式的置中 
        paragraphStyle.alignment = .center
        //建立樣式屬性的字典(字型大小、段落樣式)
        let attributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 20),NSParagraphStyleAttributeName: paragraphStyle] //將詩文內容以對應的樣式屬性顯示
        txtArticle.attributedText = NSAttributedString(string: txtViewText! , attributes: attributes)
        

    }
    
}
