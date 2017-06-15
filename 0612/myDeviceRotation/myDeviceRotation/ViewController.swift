

import UIKit

class ViewController: UIViewController {

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
        print("寬:\(size.width) 高:\(size.height)")
    }
}

