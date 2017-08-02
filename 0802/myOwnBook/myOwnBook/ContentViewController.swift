//
//  ContentViewController.swift
//  myOwnBook
//
//  Created by chang on 2017/8/2.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var imgContent: UIImageView!
    @IBOutlet weak var lblPage: UILabel!
    //紀錄目前頁碼(供pageViewcontroller傳遞頁碼使用)
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblPage.text = "\(currentPage)"
        
        //準備檔名
        let fileName = String(format: "page%i.jpg", currentPage)
        imgContent.image = UIImage(named: fileName)
    }
    
    //失效的手勢，所有系統手勢已經被PageViewController補捉了，只能使用自訂手勢解決
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        print("點擊手勢")
    }
    


}
