import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var imageViews = [UIImageView]()
    var counter = 0
    var timerPageCount = 0  //由timer變動的目前頁碼
    weak var timer:Timer!  //宣告自動翻頁的計時器
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViews.append(UIImageView(image: UIImage(named: "a.jpg")))
        imageViews.append(UIImageView(image: UIImage(named: "b.jpg")))
        imageViews.append(UIImageView(image: UIImage(named: "c.jpg")))
        for i in 1 ... 10{
            imageViews.append(UIImageView(image: UIImage(named: String(format: "%02d.jpg",i))))
        }
        //幾頁及起始頁
        pageControl.numberOfPages = imageViews.count
        pageControl.currentPage = 0
        //使用delegate才叫呼叫scrollViewDidScroll Method
        scrollView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let rectScroll = scrollView.bounds
        var totalImageViewSize = CGSize() //可以用CGSize.zero代替
        var leftImage:UIImageView?
        
        for imageView in imageViews{
            imageView.contentMode = .scaleToFill
            if leftImage == nil{
                imageView.frame = rectScroll
            }else{
                imageView.frame = leftImage!.frame.offsetBy(dx: leftImage!.frame.size.width, dy: 0)
            }
            
            leftImage = imageView
            totalImageViewSize = CGSize(width: totalImageViewSize.width + imageView.frame.size.width, height: rectScroll.size.height)
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = totalImageViewSize
        
        timer = Timer.scheduledTimer(withTimeInterval: 3.5, repeats: true, block: { (timer) in
            if self.timerPageCount < self.pageControl.numberOfPages - 1{
            self.timerPageCount += 1
                //self.pageControl.currentPage = self.timerPageCount
            }else{
                self.timerPageCount = 0
                //self.pageControl.currentPage = 0
            }
            let imageFrame = CGRect(x: self.scrollView.bounds.size.width*CGFloat(self.timerPageCount), y: 0, width: self.scrollView.bounds.size.width, height: self.scrollView.bounds.size.height)
            self.scrollView.scrollRectToVisible(imageFrame, animated: true)
        })
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        counter += 1
        print("ScrollView被捲動")
        
        var currentPage = 0
        let diff = (scrollView.contentOffset.x - scrollView.bounds.width/2) / scrollView.bounds.width
        
        if diff >= 0.5
        {
            currentPage = Int(diff) + 1
        }else if diff<0.5 && diff >= -0.5
        {
            currentPage = 0
        }
        pageControl.currentPage = currentPage
        timerPageCount = pageControl.currentPage
    }


}

