//
//  ViewController.swift
//  WebKitExample
//
//  Created by Isrrael Torres Alvarado on 26/11/21.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var contentWEB: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://es-la.facebook.com/") else { return }
        let request = URLRequest(url: url)
        contentWEB.load(request)
        contentWEB.navigationDelegate = self
        
    }

}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            
        loading.isHidden = false
        loading.startAnimating()
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        print(webView.url?.absoluteString)
        
        loading.stopAnimating()
    }
        
}

