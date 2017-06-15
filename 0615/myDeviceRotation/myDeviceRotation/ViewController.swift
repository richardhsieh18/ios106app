

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imgBook: UIImageView!
    
    @IBOutlet weak var animationBtn: UIButton!
    
    /*
     UIView動畫可改變的屬性
     frame
     bounds
     center
     transform
     alpha
     backgroundColor
     contentStretch
    */
    
    
    var DeviceWidth: CGFloat!
    var DeviceHeight: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch self.traitCollection.userInterfaceIdiom {
        case .pad:
            print("此裝置為ipad")
        case .phone:
            print("此裝置為iPhone")
        case .tv:
            print("此裝置為AppTV")
        case .carPlay:
            print("此裝置為CarPlay")
        case .unspecified:
            print("未知~?")
        }
        
        DeviceWidth = UIScreen.main.bounds.size.width
        DeviceHeight = UIScreen.main.bounds.size.height
        
        print("\(DeviceWidth)   \(DeviceHeight)")
        //此處orientation無值
        /*
        let orientation = UIDevice.current.orientation
        
        switch orientation {
            case .portrait,.portraitUpsideDown:
                imgBackground.image = UIImage(named: "picPortrait.jpg")
            case.landscapeLeft,.landscapeRight:
                imgBackground.image = UIImage(named: "picLandscape.jpg")
            default:
                imgBackground.image = UIImage(named: "picPortrait.jpg")
        }
        */

    }
    
    override func viewDidLayoutSubviews() {
        let orientation = UIDevice.current.orientation
        
        switch orientation {
        case .portrait,.portraitUpsideDown:
            
            imgBook.image = UIImage(named: "PImage")
            imgBackground.image = UIImage(named: "picPortrait.jpg")
        case.landscapeLeft,.landscapeRight:
            imgBackground.image = UIImage(named: "picLandscape.jpg")
            imgBook.image = UIImage(named: "LImage")
        default:
            imgBackground.image = UIImage(named: "picPortrait.jpg")
            imgBook.image = UIImage(named: "PImage")
        }
        
        imgBackground.frame = CGRect(x: 0, y: 0, width: DeviceWidth, height: DeviceHeight)
        
        self.view.bringSubview(toFront: imgBook)
        self.view.bringSubview(toFront: animationBtn)
    }


    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .all
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        switch newCollection.horizontalSizeClass{
        case .compact:
            print("Compact Width")
        case .regular:
            print("Regular Width")
        case .unspecified:
            print("Width unspecified")
        }
        switch newCollection.verticalSizeClass {
        case .compact:
            print("Compact Height")
        case .regular:
            print("Regular Height")
        case .unspecified:
            print("Height Unspecified")
        }
        //將閉包放在alongsideTransition: 會立即執行
//        coordinator.animate(alongsideTransition: { (context) in
//            self.animationBtn(nil)
//        }, completion: nil)
        //將閉包放在completion:  完成後才執行較恰當
        coordinator.animate(alongsideTransition:nil, completion:  { (context) in
            self.animationBtn(nil)
        })

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        switch UIDevice.current.orientation {
        case .faceDown:
            print("裝置面朝下")
        case .faceUp:
            print("裝置面朝上")
        case .landscapeLeft:
            print("裝置橫向向左")
        case .landscapeRight:
            print("裝置橫向向右")
        case .portrait:
            print("裝置直立")
        case .portraitUpsideDown:
            print("上下顛倒")
        case .unknown:
            print("無法判定")
        }
        DeviceWidth = size.width
        DeviceHeight = size.height
        //self.animationBtn(nil)
        print("寬:\(DeviceWidth!) 高:\(DeviceHeight!)")
    }
    
    @IBAction func animationBtn(_ sender: UIButton!)
    {
//        UIView.animate(withDuration: 1.0 ){
//                self.imgBook.frame.origin.x += self.DeviceWidth - self.imgBook.frame.size.width
//                //self.imgBook.frame.origin.y += self.DeviceHeight - self.imgBook.frame.size.height
//        }
        /*
        UIView.animate(withDuration: 2.0, animations:{
            self.imgBook.frame.origin.x += self.DeviceWidth - self.imgBook.frame.size.width
        }) {(finished) in if finished{
                    UIView.animate(withDuration: 1.0 ){
                            //self.imgBook.frame.origin.x += self.DeviceWidth - self.imgBook.frame.size.width
                            self.imgBook.frame.origin.y += self.DeviceHeight - self.imgBook.frame.size.height
                    }
                }
        }
        */
        
        UIView.animate(withDuration: 2.0, animations: {
            self.imgBook.frame.origin.x = self.DeviceWidth - self.imgBook.frame.size.width
        })  { (finished) in
            UIView.animate(withDuration: 2.0, animations: {
                self.imgBook.frame.origin.y = self.DeviceHeight - self.imgBook.frame.size.height
                self.imgBook.alpha = 0.2
            }, completion: { (finished) in
                UIView.animate(withDuration: 2.0, animations: {
                    self.imgBook.frame.origin.x = 0
                }, completion: { (finished) in
                    UIView.animate(withDuration: 2.0, animations: {
                        self.imgBook.frame.origin.y = 0
                        self.imgBook.alpha = 1
                    })
                })
            })
        }
    }
}
