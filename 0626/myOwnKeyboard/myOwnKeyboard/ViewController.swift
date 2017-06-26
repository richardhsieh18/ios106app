//
//  ViewController.swift
//  myOwnKeyboard
//
//  Created by chang on 2017/6/26.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //方法一
    @IBAction func onExit(_ sender: UITextField) {
        //return鍵按下後收鍵盤
        sender.resignFirstResponder()
    }
}

