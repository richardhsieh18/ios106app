//
//  ViewController.swift
//  myownSliderSwitch
//
//  Created by chang on 2017/6/26.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //slider
        slider.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)

    }

    func valueChanged(_ sender: UISlider) {
        print("狀態改變\(sender.value)")
        
    }

    @IBAction func switchPress(_ sender: UISwitch) {
        if sender.isOn{
            self.view.backgroundColor = UIColor.brown
        }else{
            self.view.backgroundColor = UIColor.white
        }
        
    }
}

