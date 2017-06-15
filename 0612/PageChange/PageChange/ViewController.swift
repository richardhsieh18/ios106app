
import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var txtName: UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("viewOne載入完成")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewOne即將被加入")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewOne確實加入")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewOne已經完成介面配置")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewOne即將從hirenchy消失，即將換頁時呼叫")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewOne確實從hirenchy消失，換頁時呼叫")
    }
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

    }
    
    deinit
    {
            print("viewOne被釋放")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue1" {
            let secondVC = segue.destination as! SecondViewController
            secondVC.str = "Viva"
            secondVC.firstVC = self
        }else if segue.identifier == "segue2" {
            print("轉換到其他頁")
        }
    }
    
    @IBAction func onClick(_ sender: UIButton) {
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SecondViewController")
            //show(vc, sender: nil)
            present(vc, animated: true, completion: nil)
    }
    
    @IBAction func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        print("滑動動動動次")
        self.performSegue(withIdentifier: "segue1", sender: nil)
        
    }

    @IBAction func handleSwipeUp(_ sender: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "segue2", sender: nil)
    }

}

