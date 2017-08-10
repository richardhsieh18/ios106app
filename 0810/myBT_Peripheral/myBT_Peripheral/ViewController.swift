//
//  ViewController.swift
//  myBT_Peripheral
//
//  Created by chang on 2017/8/10.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController,CBPeripheralManagerDelegate{
    
    //藍牙服務代碼
    let strService = "25ADA29E-CA1E-4E47-BD46-8C2205B6B1D1"
    //訊息通知功能
    let strCharacteristic1 = "5D79B27B-532E-417E-B82E-D92C45C98E40"
    //讓Central控制器寫入資料的功能
    let strCharacteristic2 = "59C71EF1-E86C-453E-BE2D-8A705EF82ADD"
    
    @IBOutlet weak var txtInfo: UITextView!
    @IBOutlet weak var lblSend: UILabel!
    @IBOutlet weak var swfPower: UISwitch!
    
    var peripheralManager: CBPeripheralManager!
    var arrCharacteristics = [CBMutableCharacteristic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)

        
    }

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            txtInfo.text = "藍牙啟動中"
        case .poweredOff:
            txtInfo.text = "藍牙未開啟"
            return
        default:
            return
        }
        //指定藍牙服務代碼
        let service = CBMutableService(type: CBUUID(string: strService), primary: true)
        //初始化第一個通知功能
        var characteristic = CBMutableCharacteristic(type: CBUUID(string: strCharacteristic1), properties: .notify, value: nil, permissions: .readable)
        
        arrCharacteristics.append(characteristic)
        //初始化第二個通知功能
        characteristic = CBMutableCharacteristic(type: CBUUID(string: strCharacteristic2), properties: .write, value: nil, permissions: .writeable)
        
        arrCharacteristics.append(characteristic)
        //將兩個功能加入到藍牙服務中
        service.characteristics = arrCharacteristics
        //將服務加入到藍牙裝置，觸發<2號代理方法>
        peripheralManager.add(service)
    }
    
    //<2號代理方法>廣播
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        
        
        if error != nil
        {
            txtInfo.text = "\(error!.localizedDescription)"
            return
        }
        txtInfo.text = "服務已加入藍牙裝置中"
        
        let deviceName = UIDevice.current.name
        //開始廣播
        peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey : [service.uuid],CBAdvertisementDataLocalNameKey: deviceName])
        let q = DispatchQueue.global(qos: .default)
        q.async {
            var i = 0
            
            while true
            {
                i += 1
                //製作要送出去的data
                let strData = "\(i)".data(using: .utf8)!
                
                //傳送更新到第一個通知功能
                self.peripheralManager.updateValue(strData, for: self.arrCharacteristics[0], onSubscribedCentrals: nil)
                //傳送出去的數字
                DispatchQueue.main.async(execute: { 
                    self.lblSend.text = "\(i)"
                })
                //讓Global Queue暫停一秒
                Thread.sleep(forTimeInterval: 1)
            }
        }
    }
    //<3號代理方法>當從Central控制器接到寫入的資料時(假設第二個寫入功能送過來的是"ON"或"OFF")
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        //取得Central控制器送過來的資訊
        let arrRequest = requests.first
        //將傳來的資訊還原成文字(可能是"ON"或"OFF"，或其他文字)
        let strReceived = String(data: arrRequest!.value!, encoding: .utf8)!
        if strReceived == "ON"
        {
            //開關打開
            swfPower.isOn = true
            //調整背景顏色
            self.view.backgroundColor = UIColor.green
        }
        else if strReceived == "OFF"
        {
            swfPower.isOn = false
            self.view.backgroundColor = UIColor.gray
        }
        //方法一，回應Central已經收到資料，若不回應，介面的變動會延遲8-20才對有開關的動作
        peripheralManager.respond(to: arrRequest!, withResult: .success)
        
        //方法二，回應Central已經收到全部資料
//        for request in requests
//        {
//            peripheralManager.respond(to: request, withResult: .success)
//        }
    }
    
    
}

