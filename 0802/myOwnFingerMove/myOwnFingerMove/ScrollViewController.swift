//
//  scrollViewController.swift
//  myOwnFingerMove
//
//  Created by chang on 2017/8/3.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize.width = scrollView.frame.width * 3
        let viewColors = [UIColor.red,UIColor.blue,UIColor.green]
        for i in 0 ..< 3{
            let oneView = UIView(frame: CGRect(x: CGFloat(i)*scrollView.frame.width, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
            oneView.backgroundColor = viewColors[i]
            scrollView.addSubview(oneView)
        }
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
