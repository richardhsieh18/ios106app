//
//  ViewController.swift
//  myownSqliteDB
//
//  Created by chang on 2017/7/6.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit
//引入兩個pickerView協定
class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //原先的資料庫連線
    var db:OpaquePointer? = nil
    
    @IBOutlet weak var txtNo: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var pkvGender: UIPickerView!
    @IBOutlet weak var pkvClass: UIPickerView!
    //設定btn Disabled
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    //記錄單一資料行
    var dicRow = [String:Any?]()
    //記錄查詢到的資料(離線資料集)
    var arrTable = [[String:Any?]]()
    //目前資料行的索引值
    var currentRow = 0
    
    let arrClass = ["智能裝置設計","手機程式設計","網頁程式設計"]
    let arrGenger = ["女","男"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //運用該程式的delegate取得db
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            db = appDelegate.getDB()
        }
        //設定兩個pickerView的delegate與datasource
        pkvClass.delegate = self
        pkvClass.dataSource = self
        pkvGender.delegate = self
        pkvGender.dataSource = self
        
    }

    //MARK: 查詢按鈕
    
    @IBAction func queryBtn(_ sender: UIButton) {
        
        let sql = "SELECT stu_no,name,gender,picture,phone,address,email,class FROM student order by stu_no"
        //將查詢指令轉換成c語言的字串
        let cSql = sql.cString(using: .utf8)
        print(cSql!)
        //宣告儲存查詢結果的變數，連線資料集
        var statement:OpaquePointer? = nil
        // 0以下,-1表示不限定sql指令的長度, nil位置為預留參數，目前沒有作用
        sqlite3_prepare(db, cSql!, -1, &statement, nil)
        //原本sql停留在begin，step後才會往下讀一筆
        while sqlite3_step(statement) == SQLITE_ROW {
            //印stu_no
            let stu_no = sqlite3_column_text(statement, 0)
            let cStuNO = String(cString:stu_no!)
            //print(stu_no!)
            //print(cStuNO)
            
            //印stu_name
            let stu_name = sqlite3_column_text(statement, 1)
            let cStuName = String(cString:stu_name!)
            //print(stu_name!)
            //print(cStuName)
            
            //讀取之後的欄位gender,picture,phone,address,email,class
            //取得gender Int32 需先轉成Int給pickerView用
            let stu_gender = Int(sqlite3_column_int(statement, 2))
            //讀取圖片外要先讀取圖片長度
            
            
            //讀取檔案每一個位元的資料
            var stu_image:Data?
            if let totalBytes = sqlite3_column_blob(statement, 3)
            {
                let length = sqlite3_column_bytes(statement, 3)
                stu_image = Data(bytes: totalBytes, count: Int(length))
            }
            
            let stu_phone = sqlite3_column_text(statement, 4)
            let cStuPhone = String(cString:stu_phone!)
            let stu_address = sqlite3_column_text(statement, 5)
            let cStuAddress = String(cString:stu_address!)
            let stu_email = sqlite3_column_text(statement, 6)
            let cStuEmail = String(cString:stu_email!)
            let stu_class = sqlite3_column_text(statement, 7)
            let cStuClass = String(cString:stu_class!)
            
            //根據查詢到的每一個欄位來準備字典
            dicRow = ["no":cStuNO,"name":cStuName,"gender":stu_gender,"picture":stu_image,"phone":cStuPhone,"address":cStuAddress,"email":cStuEmail,"class":cStuClass]
            //將字典加入陣列
            arrTable.append(dicRow)
            //得到陣列後關閉與資料庫連線
           
        }
        sqlite3_finalize(statement)
        //print("離線資料集:\(arrTable)")
        if arrTable.count > 0 {
            txtNo.text = arrTable[0]["no"] as? String
            txtName.text = arrTable[0]["name"] as? String
            //Int32 不能cast to Int
            pkvGender.selectRow(arrTable[0]["gender"] as! Int, inComponent: 0, animated: true)
            if let aPic = arrTable[0]["picture"]!
            {
                imgPicture.image = UIImage(data: aPic as! Data)
            }else{
                imgPicture.image = nil
            }
            txtPhone.text = arrTable[0]["phone"] as? String
            txtAddress.text = arrTable[0]["address"] as? String
            txtEmail.text = arrTable[0]["email"] as? String
            
            for (index,item) in arrClass.enumerated() {
                if item == arrTable[0]["class"] as! String {
                    pkvClass.selectRow(index, inComponent: 0, animated: true)
                    //如果對到相同選項，就不再跑下一次迴圈
                    break
                }
            }
            
            
            //讓按鈕Enabled
            btnNext.isEnabled = true
            btnPrevious.isEnabled = true
            btnUpdate.isEnabled = true
            btnDelete.isEnabled = true
        }
        
    }
    
    @IBAction func btnPrevious(_ sender: UIButton) {
        if currentRow > 0 {
            currentRow -= 1
        }
        txtNo.text = arrTable[currentRow]["no"] as? String
        txtName.text = arrTable[currentRow]["name"] as? String
        pkvGender.selectRow(arrTable[currentRow]["gender"] as! Int, inComponent: 0, animated: true)
        
        if let aPic = arrTable[currentRow]["picture"]!
        {
            imgPicture.image = UIImage(data: aPic as! Data)
        }else{
            imgPicture.image = nil
        }
        
        txtPhone.text = arrTable[currentRow]["phone"] as? String
        txtAddress.text = arrTable[currentRow]["address"] as? String
        txtEmail.text = arrTable[currentRow]["email"] as? String
        
        for (index,item) in arrClass.enumerated() {
            if item == arrTable[currentRow]["class"] as! String {
                pkvClass.selectRow(index, inComponent: 0, animated: true)
                //如果對到相同選項，就不再跑下一次迴圈
                break
            }
        }
    }

    @IBAction func btnNext(_ sender: UIButton) {
        currentRow += 1
        if currentRow >= arrTable.count {
             currentRow = 0
        }
        txtNo.text = arrTable[currentRow]["no"] as? String
        txtName.text = arrTable[currentRow]["name"] as? String
        pkvGender.selectRow(arrTable[currentRow]["gender"] as! Int, inComponent: 0, animated: true)
        
        if let aPic = arrTable[currentRow]["picture"]!
        {
            imgPicture.image = UIImage(data: aPic as! Data)
        }else{
            imgPicture.image = nil
        }
        txtPhone.text = arrTable[currentRow]["phone"] as? String
        txtAddress.text = arrTable[currentRow]["address"] as? String
        txtEmail.text = arrTable[currentRow]["email"] as? String
        
        for (index,item) in arrClass.enumerated() {
            if item == arrTable[currentRow]["class"] as! String {
                pkvClass.selectRow(index, inComponent: 0, animated: true)
                //如果對到相同選項，就不再跑下一次迴圈
                break
            }
        }
    }
    //MARK: 實作UIPickerView DataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {

        return 1
    }
    //為兩個滾輪加入不同的row數
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //性別
        if pickerView.tag == 0 {
            return arrGenger.count
        }//班別
        else if pickerView.tag == 1{
            return arrClass.count
        }else{
            return 0
        }
    }

    //新增資料
    @IBAction func btnInsert(_ sender: UIButton) {
        if db != nil{
            //準備要存入的圖片，先轉成NSData
            let imageData = UIImageJPEGRepresentation(imgPicture.image!, 0.5)! as NSData
            //準備SQL插入指令，要先在editor驗證該指令是否正確
            let sql = String(format: "insert into student (stu_no,name,gender,picture,phone,address,email,class) values ('%@','%@',%li,?,'%@','%@','%@,','%@')", txtNo.text!,txtName.text!, pkvGender.selectedRow(inComponent: 0),txtPhone.text!,txtAddress.text!,txtEmail.text!,arrClass[pkvClass.selectedRow(inComponent: 0)])
            //將sql指令轉成c語言字串
            let cSql = sql.cString(using: .utf8)
            //宣告儲存執行結果的變數
            var statement:OpaquePointer? = nil
            //執行sql指令
            sqlite3_prepare(db, cSql, -1, &statement, nil)
         //將照片存入資料庫欄位(第二個參數1，指的是SQL指令?所在的位置，此位置從1起算)
            sqlite3_bind_blob(statement, 1, imageData.bytes, Int32(imageData.length), nil)
            
            if sqlite3_step(statement) == SQLITE_DONE{
                print("資料新增成功")
                let alert = UIAlertController(title: "資料庫訊息", message: "資料新增成功", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
            }else{
                print("資料新增失敗")
            }
            sqlite3_finalize(statement)
        }
        
        
    }
    @IBAction func btnUpdate(_ sender: UIButton) {
        
    }
    @IBAction func btnDelete(_ sender: UIButton) {
        
    }
    //MARK: 實作UIPickerView Delegate
    //顯示title
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return arrGenger[row]
        }//班別
        else if pickerView.tag == 1{
            return arrClass[row]
        }else{
            return ""
        }
    }
    //MARK:使用照相機
    @IBAction func btnTakePicture(_ sender: Any) {
        //檢查設備是否配備相機
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .camera
            imagePickerController.delegate = self
            show(imagePickerController, sender: self)
        }else{
            print("沒有照相機")
        }
    }
    
    @IBAction func btnPhotoAlbum(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            show(imagePickerController, sender: self)
        }else{
            print("沒有相簿")
        }
    }
    
    //MARK:完成影像挑選後
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgPicture.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
}

