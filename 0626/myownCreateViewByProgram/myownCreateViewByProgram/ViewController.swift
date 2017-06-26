//
//  ViewController.swift
//  myownCreateViewByProgram
//
//  Created by chang on 2017/6/26.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //準備讓UIButton呼叫的函式
    func onClick(_ sender:UIButton){
        print("按鈕被按")
        self.view.backgroundColor = UIColor.black
        self.view.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(type: .system)
        button.setTitle("您好", for: .normal)
        
        button.frame = CGRect(x: 20, y: 20, width: 100, height: 40)
        //#selector的用法
        button.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        

    }

}

