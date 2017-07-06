//
//  ViewController.swift
//  myownSqliteDB
//
//  Created by chang on 2017/7/6.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var db:OpaquePointer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            db = appDelegate.getDB()
        }
        
    }

    @IBAction func queryBtn(_ sender: UIButton) {
        
        let sql = "SELECT stu_no,name FROM student order by stu_no"
        let cSql = sql.cString(using: .utf8)
        print(cSql!)
        //宣告儲存查詢結果的變數
        var statement:OpaquePointer? = nil
        // -1 表示不限定sql指令的長度, nil位置為預留參數，目前沒有作用
        sqlite3_prepare(db, cSql!, -1, &statement, nil)
        //原本sql停留在begin，step後才會往下讀一筆
        while sqlite3_step(statement) == SQLITE_ROW {
            //印stu_no
            let stu_no = sqlite3_column_text(statement, 0)
            let cStuNO = String(cString:stu_no!)
            print(stu_no!)
            print(cStuNO)
            //印stu_name
            let stu_name = sqlite3_column_text(statement, 1)
            let cStuName = String(cString:stu_name!)
            print(stu_name!)
            print(cStuName)
        }
        
    }



}

