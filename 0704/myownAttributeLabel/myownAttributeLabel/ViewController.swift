//
//  ViewController.swift
//  myownAttributeLabel
//
//  Created by chang on 2017/7/4.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributedString = NSMutableAttributedString(string: "Hello")
        let font50 = UIFont.systemFont(ofSize: 50)
        //NSMakeRange(起始位置, 長度)
        attributedString.addAttribute(NSFontAttributeName, value: font50, range: NSMakeRange(0, 1))
        
        //格式化最後一個字大小
        let font30 = UIFont.systemFont(ofSize: 30)
        //NSMakeRange(起始位置, 長度)
        attributedString.addAttribute(NSFontAttributeName, value: font30, range: NSMakeRange(4, 1))
        
        //格式化字型顏色
        let redColor = UIColor.red
        let backColor = UIColor.lightGray
        attributedString.addAttribute(NSForegroundColorAttributeName, value: redColor, range: NSMakeRange(1, 3))
        attributedString.addAttribute(NSBackgroundColorAttributeName, value: backColor, range: NSMakeRange(0, 5))

        
        
        
        label.attributedText = attributedString

    }


}

