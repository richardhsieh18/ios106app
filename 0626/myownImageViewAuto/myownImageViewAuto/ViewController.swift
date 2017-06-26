import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1 ... 10{
            let fileName = String(format: "%02d.jpg", i)
            images.append(UIImage(named: fileName)!)
        }
        
        imageView.animationImages = images
        imageView.contentMode = .scaleAspectFill
        imageView.animationDuration = 10
        imageView.animationRepeatCount = 2
        
        imageView.startAnimating()
        
    }


}

