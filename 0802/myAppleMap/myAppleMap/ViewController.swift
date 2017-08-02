//
//  ViewController.swift
//  myAppleMap
//
//  Created by chang on 2017/7/21.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit
import MapKit
import SafariServices //引入瀏覽器的函式庫

//以定位管理員進行定位，請遵循以下step1~step7的步驟
class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    //初始化定位管理員
    let locationManager = CLLocationManager()

    var arrAnnotation = [MKPointAnnotation]()
    
    
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var lblDirection: UILabel!  //方向
    @IBOutlet weak var lblAltitude: UILabel!  //高度
    @IBOutlet weak var lblLatitude: UILabel!  //緯度
    @IBOutlet weak var lblLongitude: UILabel!  //經度
    //記錄點選的大頭針所在經緯度位置
    var selectedPinLocation: CLLocationCoordinate2D!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        //指定定位管理員的代理人
        locationManager.delegate = self
        
        myMap.showsUserLocation = true
        myMap.delegate=self
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 25.037531, longitude: 121.5639969)
        annotation.title = "台北市政府"
        //此行已經被detailCalloutAccessoryView取代
        annotation.subtitle = "武嶺"
        arrAnnotation.append(annotation)
        //myMap.addAnnotation(annotation)
        
        annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 24.037531, longitude: 121.5639969)
        annotation.title = "台中市政府"
        annotation.subtitle = "奮起湖"
        arrAnnotation.append(annotation)
        
        
        //第三支大頭針
        annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 24.203235, longitude: 121.481963)
        annotation.title = "太魯閣"
        annotation.subtitle = "花蓮縣秀林鄉"
        arrAnnotation.append(annotation)
        
        //第四支大頭針
        annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 21.948331, longitude: 120.779752)
        annotation.title = "乘龍"
        annotation.subtitle = "墾丁"
        arrAnnotation.append(annotation)
        
        //第五支大頭針
        annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 23.018839, longitude: 120.136168)
        annotation.title = "水箭龜"
        annotation.subtitle = "台江"
        arrAnnotation.append(annotation)

        myMap.addAnnotations(arrAnnotation)
        
        //訂出地圖上多邊形的轉折點
        var area = [CLLocationCoordinate2D]()
        area.append(CLLocationCoordinate2D(latitude: 24.2013, longitude: 120.5810))
        area.append(CLLocationCoordinate2D(latitude: 24.2013, longitude: 120.6559))
        area.append(CLLocationCoordinate2D(latitude: 24.1380, longitude: 120.6401))
        area.append(CLLocationCoordinate2D(latitude: 24.1424, longitude: 120.5783))
        //產生多邊形
        let polygon = MKPolygon(coordinates: &area, count: area.count)
        //將多邊形加入地圖
        myMap.add(polygon)
        

    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("地圖範圍改變")
        //暫時停止定位
        locationManager.stopUpdatingLocation()
    }
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("地圖完成載入")
        //重新恢復定位
        locationManager.startUpdatingLocation()
    }
    
    
    //請定位管理員開始定位(不可以在viewDidLoad)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //開始定位，觸發定位完成的代理事件, 一定要先實作，以下的程式碼才會正常
        locationManager.startUpdatingLocation()
        //設定地圖的顯示範圍，以使者用的GPS為位置中心點，以中心點擴張的公尺
        let viewRegion = MKCoordinateRegionMakeWithDistance(myMap.userLocation.coordinate, 500, 500)
        //將地圖調整到設定範圍
        myMap.setRegion(viewRegion, animated: true)
        //以下兩行取代上一行，為別人的範例
//        let adjustRegion = myMap.regionThatFits(viewRegion)
//        myMap.setRegion(adjustRegion, animated: true)
        //開始偵測設備前端的方位
        locationManager.startUpdatingHeading()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //畫面消失時，停止定位
        locationManager.stopUpdatingLocation()
        
        //停止偵測設備前端的方位
        locationManager.stopUpdatingHeading()
    }
    
    //MARK: Target Action
    
    @IBAction func segmentControlPressed(_ sender: UISegmentedControl)
    {
        //依據切換狀態，更換地圖型態
        switch sender.selectedSegmentIndex {
        case 0:
            myMap.mapType = .standard
        case 1:
            myMap.mapType = .satellite
        case 2:
            myMap.mapType = .hybrid
        case 3:
            //定義3D的地標位置
            let ground = CLLocationCoordinate2D(latitude: CLLocationDegrees(lblLatitude.text!)!, longitude: CLLocationDegrees(lblLongitude.text!)!)
            //定義攝影機的座標位置
            let eyeFrom = CLLocationCoordinate2D(latitude: CLLocationDegrees(lblLatitude.text!)! + 0.003, longitude: CLLocationDegrees(lblLongitude.text!)!)
            //定義攝影位置與高度(視角)
            let camera = MKMapCamera(lookingAtCenter: ground, fromEyeCoordinate: eyeFrom, eyeAltitude: 50)
            //改變地圖以3D方式呈現
            myMap.mapType = .satelliteFlyover
            //myMap.isPitchEnabled = true
            //在地圖上加上攝影機
            myMap.camera = camera
            
        default:
            myMap.mapType = .hybrid
        }
    }
    
    //MARK: 自定函式
    func buttonPress(_ sender:UIButton){
        //方法一彈出資訊中的按鈕連接到特定網頁
//        if sender.tag == 100 {
//            let url = URL(string: "http://www.taroko.gov.tw")
//            let safari = SFSafariViewController(url: url!)
//            show(safari, sender: self)
//            
//        }else if sender.tag == 200{
//            let url = URL(string: "http://www.taroko.gov.tw")
//            let safari = SFSafariViewController(url: url!)
//            show(safari, sender: self)
//        }else if sender.tag == 300 {
//            let url = URL(string: "http://www.taroko.gov.tw")
//            let safari = SFSafariViewController(url: url!)
//            show(safari, sender: self)
//        }
        
        //方法二彈出資訊中的按鈕進行導航(從目前位置導航到特定的經緯度)
        //取得地圖上的目前位置
        let currentMapItem = MKMapItem.forCurrentLocation()
        //從大頭針上取得緯度和經度，製成導航地圖的標示
        let markDestination = MKPlacemark(coordinate: selectedPinLocation)
        //製作導航終點的位置
        let destMapItem = MKMapItem(placemark: markDestination)
        destMapItem.name = "導航終點"
        destMapItem.phoneNumber = "888888888"
        //製作導航起點和終點的陣列
        let arrNavi = [currentMapItem,destMapItem]
        //設定導航選項的字典
        let optionNavi = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
        MKMapItem.openMaps(with: arrNavi, launchOptions: optionNavi)
    }
    //準備大頭針的樣式
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation{
            return nil
        }
        
        
        //方法一
//        var annView = myMap.dequeueReusableAnnotationView(withIdentifier: "Pin") as? MKPinAnnotationView
//        if annView == nil {
//        //使用大頭針樣式來初始化
//            annView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
//        }
//        print(annView)
//        
//        if annotation.title! == "台北市政府" {
//            annView?.pinTintColor = UIColor.green
//        }else if annotation.title! == "台中市政府" {
//            annView?.pinTintColor = UIColor.orange
//        }else{
//            annView?.pinTintColor = UIColor.purple
//        }

        //方法二，使用自訂圖片當大頭針
        var annView = myMap.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annView == nil {
            //使用一般樣式來初始化
            annView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        }
        
        
        if annotation.title! == "台中市政府"{
            //準備左側的裝飾圖
            let imageView = UIImageView(image: UIImage(named: "卡比獸.png"))
            annView?.image = imageView.image //指定大頭針的自訂圖片
            annView?.leftCalloutAccessoryView = imageView //指定彈出資訊的左側圖片
            //準備右下的詳細資料
            let label = UILabel()
            label.numberOfLines = 2
            label.text = "緯度:\(annotation.coordinate.latitude)\n經度:\(annotation.coordinate.longitude)"
            annView?.detailCalloutAccessoryView = label
            //準備右側的按鈕
            let button = UIButton(type: .detailDisclosure)
            button.tag  = 100
            button.addTarget(self, action: #selector(buttonPress(_:)), for: .touchUpInside)
            annView?.rightCalloutAccessoryView = button
            
        }else if annotation.title! == "太魯閣"{
            //準備左側的裝飾圖
            let imageView = UIImageView(image: UIImage(named: "快龍.png"))
            annView?.image = imageView.image //指定大頭針的自訂圖片
            annView?.leftCalloutAccessoryView = imageView //指定彈出資訊的左側圖片
            //準備右下的詳細資料
            let label = UILabel()
            label.numberOfLines = 2
            label.text = "緯度:\(annotation.coordinate.latitude)\n經度:\(annotation.coordinate.longitude)"
            annView?.detailCalloutAccessoryView = label
            //準備右側的按鈕
            let button = UIButton(type: .detailDisclosure)
            button.tag  = 200
            button.addTarget(self, action: #selector(buttonPress(_:)), for: .touchUpInside)
            annView?.rightCalloutAccessoryView = button
            
        
        }else if annotation.title! == "台北市政府"{
            //準備左側的裝飾圖
            let imageView = UIImageView(image: UIImage(named: "吉利蛋.png"))
            annView?.image = imageView.image //指定大頭針的自訂圖片
            annView?.leftCalloutAccessoryView = imageView //指定彈出資訊的左側圖片
            //準備右下的詳細資料
            let label = UILabel()
            label.numberOfLines = 2
            label.text = "緯度:\(annotation.coordinate.latitude)\n經度:\(annotation.coordinate.longitude)"
            annView?.detailCalloutAccessoryView = label
            //準備右側的按鈕
            let button = UIButton(type: .detailDisclosure)
            button.tag  = 300
            button.addTarget(self, action: #selector(buttonPress(_:)), for: .touchUpInside)
            annView?.rightCalloutAccessoryView = button
            
        }else if annotation.title! == "乘龍"{
                //準備左側的裝飾圖
                let imageView = UIImageView(image: UIImage(named: "乘龍.png"))
                annView?.image = imageView.image //指定大頭針的自訂圖片
                annView?.leftCalloutAccessoryView = imageView //指定彈出資訊的左側圖片
                //準備右下的詳細資料
                let label = UILabel()
                label.numberOfLines = 2
                label.text = "緯度:\(annotation.coordinate.latitude)\n經度:\(annotation.coordinate.longitude)"
                annView?.detailCalloutAccessoryView = label
                //準備右側的按鈕
                let button = UIButton(type: .detailDisclosure)
                button.tag  = 400
                button.addTarget(self, action: #selector(buttonPress(_:)), for: .touchUpInside)
                annView?.rightCalloutAccessoryView = button
            
            
        }else{
            //全部使用自訂圖示
            annView?.image = UIImage(named: "021-badoo.png")
        }
        

        
        
        //點大頭針後顯示標式
        annView?.canShowCallout = true
        //讓大頭針可以拖移
        annView?.isDraggable = true
        
        return annView
    }
    //大頭針的狀態改變時的代理事件
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        print("狀態:\(newState.rawValue)")
       //當結束拖曳狀態時(此處需配合方法二，才能自動釘在結束的位置)
        if newState == .ending {
            //結束大頭針的拖曳
            view.dragState = .none
            //準備右下的詳細資料
            let label = UILabel()
            label.numberOfLines = 2
            label.text = "緯度:\(view.annotation!.coordinate.latitude)\n經度:\(view.annotation!.coordinate.longitude)"
            view.detailCalloutAccessoryView = label
        }
    }
    //當使用者選定特定大頭針時
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//
//        let alert = UIAlertController(title: "地圖提示訊息", message: "要移除大頭針嗎", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "取消", style: .default, handler: nil))
//        //按下確定後移除大頭針
//        alert.addAction(UIAlertAction(title: "確定", style: .destructive) { (action) in
//            mapView.removeAnnotation(view.annotation!)
//        })
//        present(alert, animated: true, completion: nil)
//        //移除大頭針，改放在閉包裡
//        //mapView.removeAnnotation(view.annotation!)
        //記錄點選的大頭針所在位置
        selectedPinLocation = view.annotation!.coordinate
    }

    
    //回傳地圖上多邊形樣式
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        //從多邊形取得渲染之樣式
        let render = MKPolygonRenderer(overlay: overlay)
        //假如是多邊形時
        if overlay is MKPolygon
        {
            //設定渲染之填滿色彩
            render.fillColor = UIColor.red.withAlphaComponent(0.2)
            //設定渲染之筆畫顏色
            render.strokeColor = UIColor.blue.withAlphaComponent(0.5)
            //設定渲染之筆畫粗細
            render.lineWidth = 3
        }
        return render
    }
    
    //MARK: CLLocationManagerDelegate
    //定位管理員完成定位時
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //取得第一個定位資訊
        let aLocation = locations.first //locations[0]
        //把地圖的中心點設定到目前位置
        myMap.centerCoordinate = aLocation!.coordinate
        
        lblLatitude.text = "\(aLocation!.coordinate.latitude)"
        lblLongitude.text = "\(aLocation!.coordinate.longitude)"
        lblAltitude.text = "\(aLocation!.altitude)"
        //初始化地理資訊編碼器
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(aLocation!) { (placemarks, error) in
            if error != nil {
                return
            }
            //如果沒有拿到解碼後的資訊就離開
            if placemarks == nil {
                return
            }
            //列出解碼資訊
            for placemark in placemarks!
            {
                //取得定位區的行政區字典
                let addressDict = placemark.addressDictionary
                //迴圈列出字典的key值
                for key in (addressDict?.keys)!{
                    //根據key值查字典
                    let value = addressDict?[key]
                    if value is NSArray{
                        for p in value as! NSArray{
                            print("=>\(key) : \(p)")
                        }
                    }
                    if value is String{
                        print("\(key) : \(value!)")
                    }
                }
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("方位值\(newHeading.magneticHeading)")
        if newHeading.magneticHeading < 0
        {
            lblDirection.text = "未知"
        }else if newHeading.magneticHeading >= 0 && newHeading.magneticHeading < 46{
            lblDirection.text = "東北"
        }else if newHeading.magneticHeading >= 46 && newHeading.magneticHeading < 90 {
            lblDirection.text = "東"
        }else if newHeading.magneticHeading >= 91 && newHeading.magneticHeading < 136 {
            lblDirection.text = "東南"
        }else if newHeading.magneticHeading >= 136 && newHeading.magneticHeading < 181 {
            lblDirection.text = "南"
        }else if newHeading.magneticHeading >= 181 && newHeading.magneticHeading < 226 {
            lblDirection.text = "西南"
        }else if newHeading.magneticHeading >= 226 && newHeading.magneticHeading < 271 {
            lblDirection.text = "西"
        }else if newHeading.magneticHeading >= 271 && newHeading.magneticHeading < 316 {
            lblDirection.text = "西北"
        }else{
            lblDirection.text = "北"
        }
    }

}

