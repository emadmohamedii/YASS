//
//  AuthPageVC.swift
//  MovieApp
//
//  Created by Emad Habib on 06/12/2020.
//  Copyright © 2020 MAC240. All rights reserved.
//

import UIKit
import WebKit

class AuthPageVC: BaseViewController {
    
    @IBOutlet weak var webView:WKWebView!
    
    var webStringURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        if let url = URL(string: webStringURL) {
//            openWeb(url: url)
  
            if let url = URL(string: webStringURL) {
                UIApplication.shared.open(url)
            }

        }
    }
    
    
    func openWeb(url:URL)
    {
        webView.load(URLRequest(url: url))
    }
}


extension AuthPageVC : WKNavigationDelegate {
    
}
