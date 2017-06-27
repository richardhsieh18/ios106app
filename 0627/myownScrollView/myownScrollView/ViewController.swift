//
//  ViewController.swift
//  myownScrollView
//
//  Created by chang on 2017/6/26.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    let imageView = UIImageView(image: UIImage(named: "sample.jpg"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        deviceWidth = UIScreen.main.bounds.size.width
//        deviceHeight = UIScreen.main.bounds.size.height
//        print("VDL營幕寬:\(deviceWidth),高:\(deviceHeight)")

        //指派scrollView的代理人
        scrollView.delegate = self
        
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //將ImageView的大小參考成scrollView的大小
        imageView.frame = scrollView.bounds
        
        scrollView.contentSize = imageView.frame.size
        //第二段後增加
        scrollView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //print("VDLS圖片大小:\(imageView.frame.size)")
        scrollView.zoomScale = 1
        imageView.frame = scrollView.bounds

    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .all
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        //scrollView.zoomScale = 1
        //調整放大倍率
        
//        if deviceWidth <= imageView.frame.size.width{
//            scrollView.zoomScale = deviceWidth / imageView.frame.size.width
//        }else{
//            scrollView.zoomScale = imageView.frame.size.width / deviceWidth
//        }

        //print("VWT\(imageView.frame)")
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("contentOffset\(scrollView.contentOffset)")
    }


}

