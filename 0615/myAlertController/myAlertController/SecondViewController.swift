//
//  SecondViewController.swift
//  myAlertController
//
//  Created by chang on 2017/6/15.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var loginName = ""
    weak var firstVC:ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(loginName)
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        let alertController = UIAlertController(title: "你好\n\(loginName.uppercased())", message: "藍海人~~藍海人~~藍海人~~藍海人~~藍海人~~藍海人~~藍海人~~藍海人~~藍海人~~藍海人~~藍海人~~藍海人~~藍海人~~藍海人~~藍海人~~藍海人~~藍海人~~藍海人~~藍海人~~藍海人~~", preferredStyle: .alert)
        
        //let okAction = UIAlertAction(title: "確定", style: .default, handler: nil)
        let okAction = UIAlertAction(title: "Dismiss方法", style: .destructive) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        
        
        alertController.addAction(okAction)
        show(alertController, sender: nil)
    }

}
