//
//  ViewController2.swift
//  myMidTest
//
//  Created by chang on 2017/6/30.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {


    @IBOutlet weak var backBtn: UIButton!
    
    var redColor:CGFloat = 0
    var greenColor:CGFloat = 0
    var blueColor:CGFloat = 0
    //weak var FirstVC: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    //在viewDidLoad之後載入，謹記
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 3.5, delay: 1, options: .curveEaseIn, animations: {
            self.view.backgroundColor = UIColor(red: self.redColor, green: self.greenColor, blue: self.blueColor, alpha: 1)
            //self.view.backgroundColor = FirstVC.imageView1.backgroundColor
        }, completion: nil)
         
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backHome(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
