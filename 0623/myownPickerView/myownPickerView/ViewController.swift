//
//  ViewController.swift
//  myownPickerView
//
//  Created by chang on 2017/6/23.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    
    var list1 = [String]()
    var list2 = [String]()
    var selectedKind = ""
    var selectedItem = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        list1.append("球類")
        list1.append("田徑")
        list1.append("飛行")
        list1.append("體操")
        
        list2.append("棒球")
        list2.append("壘球")
        list2.append("跳傘")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UIPickerViewDataSource
    //幾個滾輪
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    //一個滾輪幾行
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return list1.count
        }else{
            return list2.count
        }
    }
    //MARK: UIPickerViewDelegate
    //方法一
    /*
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return list1[row]
        }else{
            return list2[row]
        }
    }
 */
    
    //方法二
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //width要除以2，因為有2個滾輪
        let myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.size.width/2, height: pickerView.frame.size.height))
        if component == 0 {
            myLabel.text = list1[row]
        }else{
            myLabel.text = list2[row]
        }
        myLabel.font = UIFont.systemFont(ofSize: 20)
        myLabel.backgroundColor = UIColor.purple
        return myLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if component == 0 {
            print("點到了\(list1[row])")
            selectedKind = list1[row]
            //當第1個Component被選取時，選取第2個Component的第3個元素
            pickerView.selectRow(2, inComponent: 1, animated: true)
            
        }else{
            print("點到了\(list2[row])")
            selectedItem = list2[row]

        }
        
        let alert = UIAlertController(title: "使用者選擇", message: "分類\(selectedKind), 項目\(selectedItem)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確定", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    

}

