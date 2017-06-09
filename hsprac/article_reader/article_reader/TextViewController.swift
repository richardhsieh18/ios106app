//
//  TextViewController.swift
//  article_reader
//
//  Created by chang on 2017/6/9.
//  Copyright © 2017年 changname. All rights reserved.
//

import UIKit

class TextViewController: UIViewController, UIWebViewDelegate {
    
    var urlString: String!

    @IBOutlet weak var webView: UIWebView!
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        if self.webView.canGoBack {
            self.goBackBtn.isEnabled = true
        } else {
            self.goBackBtn.isEnabled = false
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = self
        if let url = URL(string: self.urlString){
        let request = URLRequest(url: url)
        self.webView.loadRequest(request)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refresh(_ sender: Any) {
    }

    @IBOutlet weak var goBackBtn: UIBarButtonItem!

    @IBAction func goBack(_ sender: Any) {
        self.webView.goBack()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
