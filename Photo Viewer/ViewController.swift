//
//  ViewController.swift
//  Photo Viewer
//
//  Created by cdn68 on 29/06/18.
//  Copyright © 2018 cdn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var webView: UIWebView!
    
    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate  = self
        self.webView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: IBActions
    @IBAction private func doClickInstagramLogin() {
        NetworkManager.isUnreachable { _ in
            CommonUtility.showErrorCRNotifications(title: NSLocalizedString("app.title", comment: "Title in the banner"), message: NSLocalizedString("title.no.internet", comment: "When there is no internet connection."))
            return
        }
        self.webView.isHidden = false
        CommonUtility.startLoader()
        let authURL = String(format: INSTAGRAM_IDS.INSTAGRAM_GET_ACCESS_TOKEN, arguments: [INSTAGRAM_IDS.INSTAGRAM_AUTHURL,INSTAGRAM_IDS.INSTAGRAM_CLIENT_ID,INSTAGRAM_IDS.INSTAGRAM_REDIRECT_URI, INSTAGRAM_IDS.INSTAGRAM_SCOPE ])
        let urlRequest =  URLRequest.init(url: URL.init(string: authURL)!)
        self.webView.loadRequest(urlRequest)
    }
    
    //MARK: Private Methods
    private func checkRequestForCallbackURL(request: URLRequest) -> Bool {
        
        let requestURLString = (request.url?.absoluteString)! as String
        
        if requestURLString.hasPrefix(INSTAGRAM_IDS.INSTAGRAM_REDIRECT_URI) {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
            handleAuth(authToken: (String(requestURLString[range.upperBound...])))
            return false;
        }
        return true
    }
    
    private func handleAuth(authToken: String)  {
        if !authToken.isEmpty {
            UserDefaults.standard.set(authToken, forKey: UserDefaultsKeys.AuthToken)
            self.webView.isHidden = true
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PhotoGalleryViewController") as! PhotoGalleryViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        print("Instagram authentication token ==", authToken)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return checkRequestForCallbackURL(request: request)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        CommonUtility.startLoader()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        CommonUtility.stopLoader()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        CommonUtility.stopLoader()
        webViewDidFinishLoad(webView)
    }
}

