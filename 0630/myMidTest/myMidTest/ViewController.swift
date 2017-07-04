//
//  ViewController.swift
//  myMidTest
//
//  Created by chang on 2017/6/30.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    @IBOutlet weak var imageView1: UIImageView!
    
    
    override func viewDidLoad() {
        imageView1.layer.cornerRadius = 10
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        
        self.imageView1.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
        
        //self.imageView1.backgroundColor = UIColor(red: 54, green: 135, blue: 140, alpha: 0.8)
        //self.view.addSubview(imageView1)
        print(imageView1.backgroundColor!)

    }
    
    
    @IBAction func nextBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "change", sender: nil)
    
    }
    //在載入seque"change"之前，先產生vc2的實體才可以傳值過去
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        let vc2 = segue.destination as! ViewController2
        vc2.redColor = CGFloat(redSlider.value)
        vc2.blueColor =  CGFloat(greenSlider.value)
        vc2.blueColor = CGFloat(blueSlider.value)
    }
}


