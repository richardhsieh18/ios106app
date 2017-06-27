//
//  ViewController.swift
//  myOwnKeyboard
//
//  Created by chang on 2017/6/26.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextViewDelegate {
    
    var currentViewBottomYPosition:CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
        //註冊鍵盤彈出的通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        //註冊鍵盤收起的通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    //方法一
    @IBAction func onExit(_ sender: Any) {
        //return鍵按下後收鍵盤
        if let textObj = sender as? UITextField{
            textObj.resignFirstResponder()
        }
        else if let textObj = sender as? UITextView{
            textObj.resignFirstResponder()
        }
 
        
    }
    //呼叫不同鍵盤
    @IBAction func fieldTouched(_ sender: UITextField) {
        currentViewBottomYPosition = sender.frame.origin.y + sender.frame.size.height
        print(currentViewBottomYPosition)
        switch sender.tag {
        case 1:
            sender.keyboardType = .emailAddress
        case 2:
            sender.keyboardType = .decimalPad
        default:
            sender.keyboardType = .default
        }
        
    }
    
    //找subview讓subview交出控制權
    func closeKeyboard(_ sender:Any){
        for subView in self.view.subviews{
            if subView is UITextField || subView is UITextView
            {
                subView.resignFirstResponder()
            }
        }
    }
    
    //由鍵盤彈出通知呼叫的函式
    func keyboardWillShow(_ sender: Notification){
        print("鍵盤彈出")
        //找keyboard的高度
        //print(sender.userInfo!)
        if let keyboardHeight = (sender.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? NSValue)?.cgRectValue.size.height {
            
           
            let visiableHeight = self.view.frame.height - keyboardHeight
            
            if currentViewBottomYPosition > visiableHeight
            {
                //自己做的self.view.frame = CGRect(x: 0, y: -keyboardHeight, width: view.frame.width, height: view.frame.height)

                    self.view.frame.origin.y = -keyboardHeight
                    //self.view.frame = CGRect(x: 0, y: -(self.currentViewBottomYPosition - visiableHeight), width: self.view.frame.width, height: self.view.frame.height)})
                    print(keyboardHeight)
            }
        }
    }

    //由鍵盤收合通知呼叫的函式
    func keyboardWillHide(){
        print("鍵盤收合")

            self.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)

    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {

        currentViewBottomYPosition = textView.frame.origin.y + textView.frame.size.height
        print("Y軸底緣位置\(currentViewBottomYPosition)")
        return true
    }

    
}

