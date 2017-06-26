
import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var imageView: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //副檔名可以小寫
        imageView.image = UIImage(named: "sample.jpg")
        imageView.contentMode = .scaleAspectFill
        


        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //取得裝置營幕大小
        let screenRect = UIScreen.main.bounds
        //修改圖片位置和大小
        imageView.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
    }
    //定義本畫面可以支援的方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .all
    }

}

