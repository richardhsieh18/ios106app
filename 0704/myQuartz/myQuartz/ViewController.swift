//
//  ViewController.swift
//  myQuartz
//
//  Created by chang on 2017/6/30.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    var layer1:CALayer!
    var layer2:CALayer!
    var shadowLayer:CALayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var image = UIImage(named: "molang1.png")
        layer1 = CALayer()
        layer1.frame = CGRect(x: 50, y: 100, width: 200, height: 200)
        layer1.contents = image?.cgImage
        self.view.layer.addSublayer(layer1)
        
        let ratio = image!.size.width / image!.size.height
        
        image = UIImage(named: "molang2.png")
        layer2 = CALayer()
        //框線
        //layer2.borderWidth = 5
        layer2.frame = CGRect(x: 50, y: 300, width: 200, height: 200 / ratio)
        layer2.contents = image?.cgImage
        self.view.layer.addSublayer(layer2)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func valueChanged(_ sender: UISlider) {
        
        let deg = sender.value
        let arc = deg / 180 * Float.pi
        
        let rotation = CGAffineTransform(rotationAngle: CGFloat(arc))
        layer1.setAffineTransform(rotation)
        layer1.cornerRadius = CGFloat(sender.value/720 * Float(layer1.frame.width))
        layer1.masksToBounds = true
        
    }

    @IBAction func radiusBtn(_ sender: UIButton) {
        if layer2.cornerRadius == 0 {
            layer2.cornerRadius = 20
            //栽掉圓角外的區域
            layer2.masksToBounds = true
        }else{
            layer2.cornerRadius = 0
        }
    }
    
    @IBAction func switchBtn(_ sender: UISwitch) {
        if sender.isOn {
            layer2.cornerRadius = layer2.frame.width/2
            layer2.masksToBounds = true
        }else{
            layer2.cornerRadius = 0
        }
        
    }
    
    @IBAction func shadowSwitch(_ sender: UISwitch) {
        if sender.isOn{
            layer2.shadowColor = UIColor.black.cgColor
            layer2.shadowOffset = CGSize(width: 10, height: 10)
            layer2.shadowOpacity = 0.8
            layer2.shadowRadius = 5
        }else{
            layer2.shadowOffset = CGSize()
            layer2.shadowRadius = 0
        }
    }
    //上面兩個交互使用會失效，故做一個新增陰影圖層的layer
    @IBAction func radiusShadowBtn(_ sender: UISwitch) {
        if sender.isOn{
            shadowLayer = CALayer()
            layer2.cornerRadius = 20
            shadowLayer.frame = layer2.frame.offsetBy(dx: 30, dy: 30)
            shadowLayer.shadowColor = UIColor.blue.cgColor
            shadowLayer.backgroundColor = UIColor.red.cgColor
            
            shadowLayer.shadowOffset = CGSize(width: 5, height: 5)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.cornerRadius = layer2.cornerRadius
            
            view.layer.insertSublayer(shadowLayer, below: layer2)
        }else{
            layer2.cornerRadius = 0
            //這句有動畫耶
            //shadowLayer.frame = CGRect()
            
            shadowLayer.removeFromSuperlayer()
        }
        
    }
    

    

}

