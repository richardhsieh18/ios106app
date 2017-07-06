//
//  AppDelegate.swift
//  myownSqliteDB
//
//  Created by chang on 2017/7/6.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //宣告資料庫連線變數
    private var db: OpaquePointer? = nil
    //回傳資料庫連線給其他類別
    func getDB() -> OpaquePointer?{
        return db
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let fileManager = FileManager.default
        
        let sourceDB = Bundle.main.path(forResource: "MyDB", ofType: "sqlite")
        
        let destinationDB = NSHomeDirectory() + "/Documents/MyDB.sqlite"
        //如果MyDB檔案不存在執行
        if !fileManager.fileExists(atPath: destinationDB)
        {
            if let _ = try? fileManager.copyItem(atPath: sourceDB!, toPath: destinationDB){
                print("DB已成功複製")
            }
        }
        
        if sqlite3_open(destinationDB, &db) == SQLITE_OK{
            print("資料庫開啟成功")
        }else{
            print("資料庫開啟失敗")
            db = nil
        }
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        sqlite3_close(db)

    }


}

