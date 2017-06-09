//
//  SecondViewController.swift
//  PageChange
//
//  Created by chang on 2017/6/8.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var str:String!
    @IBOutlet weak var lblMessage: UILabel!
    weak var firstVC:ViewController!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("viewSecond載入完成")
        if let str = str {
            
            print("上一頁傳來:\(str)")
            lblMessage.text = str + "  " + firstVC.txtName.text!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewSecond即將被加入")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewSecond確實加入")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewSecond已經完成介面配置")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewSecond即將從hirenchy消失，即將換頁時呼叫")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewSecond確實從hirenchy消失，換頁時呼叫")
    }
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit
    {
        print("viewSecond被釋放")
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

    

}
