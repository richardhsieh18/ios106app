//
//  ViewController.swift
//  myOwnQueryLocation
//
//  Created by chang on 2017/8/2.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var txtSearch: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnSearchClicked(_ sender: UIButton) {
        if txtSearch.text == ""{
            return
        }
        let request = MKLocalSearchRequest()
        //設定搜尋地圖的關鍵字
        request.naturalLanguageQuery = txtSearch.text
        //設定搜尋範圍為地圖的範圍(此行必須在地圖載入完成後執行)
        request.region = mapView.region
        //初始化地圖搜尋物件
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if error != nil{
                return
            }
            if response == nil {
                return
            }
            for item in (response?.mapItems)!{
                self.mapView.addAnnotation(item.placemark)
            }
        }
    }

}

