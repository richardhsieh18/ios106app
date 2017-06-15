import UIKit

class ViewController: UIViewController {
    var loginSucess:Bool = false
    var uid:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let alertController = UIAlertController(title: "APP ME", message: "藍海人~~", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "確定", style: .default, handler: nil)
//        let okAction = UIAlertAction(title: "Dismiss方法", style: .default) { (action) in
//            self.dismiss(animated: true, completion: nil)
//        }
        
        alertController.addAction(okAction)
        show(alertController, sender: nil)
    }
    
    //!!!!!!!!!重要!!!!!!!!   傳值給SecondViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! SecondViewController
        secondVC.loginName = self.uid
        secondVC.firstVC = self
        
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
                let alert = UIAlertController(title: "記得登入", message: "喵星人~~", preferredStyle: .alert)
                alert.addTextField { (TextField) in
                    TextField.placeholder = "你的名字"
                }
                alert.addTextField { (TextField) in
                    TextField.placeholder = "通關密語"
                    TextField.isSecureTextEntry = true
                }
        
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                let loginAction = UIAlertAction(title: "登入", style: .default) { (action) in
                    self.uid = alert.textFields![0].text!
                    let upd = alert.textFields![1].text!
                    
                    print("帳號: \(self.uid) 密碼: \(upd)")
                    if self.uid == "tom" && upd == "1234"{
                        self.loginSucess = true
                        self.performSegue(withIdentifier: "go2", sender: nil)
                    }
                }
        
        alert.addAction(loginAction)
        alert.addAction(cancelAction)
        show(alert, sender: nil)
    }
    
}

