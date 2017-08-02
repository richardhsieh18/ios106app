//
//  ViewController.swift
//  myOwnFingerMove
//
//  Created by chang on 2017/8/2.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgStar: UIImageView!
    var touchStartPosition:CGPoint!
    var touchEndPosition:CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        imgStar.alpha = 0
    }
    //觸碰開始
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("觸碰開始\(touches.count)")
        
        if let touch = touches.first{
            touchStartPosition = touch.location(in: self.view)
            print("觸碰開始位置\(touchStartPosition)")
            //計算移動原點與中心點的差值
            let diffPosition = CGPoint(x: touchStartPosition.x - imgStar.frame.size.width / 2, y: touchStartPosition.y - imgStar.frame.size.height / 2)
            //讓星星移動到點擊位置
            imgStar.frame.origin = diffPosition
            
            
        }
    }
    //觸碰結束
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("觸碰結束")
        if let touch = touches.first{
            touchEndPosition = touch.location(in: self.view)
            print("觸碰開始位置\(touchEndPosition)")

            UIView.animate(withDuration: 0.25, animations: {
                //第一段動畫
                self.imgStar.alpha = 1
            }, completion: { (finished) in
                //第二段動畫
                self.imgStar.alpha = 0
            })
        }
    }
    //觸碰移動
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("觸碰中移動")
    }
}

