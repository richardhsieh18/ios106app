

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblSecond: UILabel!
    
    var timeLeft = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func valueChanged(_ sender: UIDatePicker) {
        timeLeft = Int(sender.countDownDuration) / 60 * 60
        lblSecond.text = "\(timeLeft)"
    }

    @IBAction func btnStartCount(_ sender: UIButton)
    {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.timeLeft -= 1
            self.lblSecond.text = "\(self.timeLeft)"
        }
    }
}

