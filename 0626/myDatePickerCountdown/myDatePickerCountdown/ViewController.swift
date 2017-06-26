

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var btnStartCount: UIButton!
    var timeLeft = 0
    weak var timer:Timer! //宣告計時器
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func valueChanged(_ sender: UIDatePicker) {
        timeLeft = Int(sender.countDownDuration) / 60 * 60
        lblSecond.text = "\(timeLeft)"
    }

    @IBAction func btnStartCount(_ sender: UIButton)
    {
        //先判斷 timer 是否為nil
        if timer != nil{
            //停止計時器
            timer.invalidate()
            print("Time Freeze")
        }else{
            btnStartCount.setTitle("停止倒數", for: .normal)
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                self.timeLeft -= 1
                if self.timeLeft >= 0{
                    self.lblSecond.text = "\(self.timeLeft)"
                }else{
                    //停止計時器，需先設定一個計時器變數
                    timer.invalidate()
                    print("Timer已停止!")
                }
            }
        }
    }
}

