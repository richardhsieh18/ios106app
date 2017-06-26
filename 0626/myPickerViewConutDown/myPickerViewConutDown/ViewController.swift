import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{

    weak var timer:Timer!
    var timeLeft = 0
    
    @IBOutlet weak var counterPickerView: UIPickerView!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var btnStartCount: UIButton!
    
    var selectedTimeLeft = 0
    
    var arrSelectedHours = [String]()       //小時
    var arrSelectedMins = [String]()         //分
    var arrSelectedSecs = [String]()        //秒
    
    var selectedHour = 0
    var selectedMin = 0
    var selectedSec = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0 ... 23 {
            arrSelectedHours.append("\(i)時")
        }
        for j in 0 ... 59 {
            arrSelectedMins.append("\(j)分")
            arrSelectedSecs.append("\(j)秒")
        }
        //print(arrSelectedHours,arrSelectedMins,arrSelectedSecs)
        
        //設定pickerView的資料來源和代理事件實作在此類別
        counterPickerView.dataSource = self
        counterPickerView.delegate = self
        
    }

    //MARK: UIPIckerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        //分別指定三個滾輪的個數
        switch component{
        case 0:
            return arrSelectedHours.count
        case 1:
            return arrSelectedMins.count
        case 2:
            return arrSelectedSecs.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch component
        {
        case 0:
            return arrSelectedHours[row]
        case 1:
            return arrSelectedMins[row]
        case 2:
            return arrSelectedSecs[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component{
        case 0:
            selectedHour = row  //以陣列索引值直接紀錄
            
        case 1:
            selectedMin = row
        case 2:
            selectedSec = row
        default:
            break
        }
        selectedTimeLeft = selectedHour*60+selectedMin*60+selectedSec
        timeLeft = selectedTimeLeft
        lblSecond.text = "\(timeLeft)秒"
    }

    @IBAction func btnStartCount(_ sender: UIButton)
    {
        
        
        //先判斷 timer 是否為nil
        if timer != nil{
            //停止計時器
            timer.invalidate()
            //self.lblSecond.text = "\(self.selectedTimeLeft)"
            //讓滾輪上的倒數時間，與剩餘時間一致
            timeLeft = selectedTimeLeft
            btnStartCount.setTitle("開始倒數", for: .normal)
            print("Time Freeze")
        }else{
            btnStartCount.setTitle("停止倒數", for: .normal)
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                self.timeLeft -= 1
                if self.timeLeft >= 0{
                    self.lblSecond.text = "\(self.timeLeft)秒"
                    print("倒數開始")
                }else{
                    //停止計時器，需先設定一個計時器變數
                    timer.invalidate()
                    print("Timer已停止!")
                    self.lblSecond.text = "\(self.selectedTimeLeft)"
                    self.btnStartCount.setTitle("開始倒數", for: .normal)
                    //讓滾輪上的倒數時間，與剩餘時間一致
                    self.timeLeft = self.selectedTimeLeft
                }
            }
        }
    }

}

