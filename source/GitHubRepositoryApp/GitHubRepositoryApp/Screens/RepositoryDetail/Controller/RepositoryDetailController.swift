//
//  RepositoryDetailController.swift
//  GitHubRepositoryApp
//
//  Created by Rajeswaran on 06/01/22.
//

import UIKit
import WebKit


class RepositoryDetailController: UIViewController {
    
    
    @IBOutlet weak var webView: WKWebView!
    
    var viewModel: RepositoryDetailViewModel
    
    init(_ viewModel: RepositoryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "RepositoryDetailController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        webViewInitialSetup()

    }
    
    private func showActivityIndicator(show: Bool) {
        if show {
            self.view.showActivityIndicator()
        } else {
            self.view.hideActivityIndicator()
        }
    }
    
    
    private func webViewInitialSetup(){
        guard let validUrl = URL(string: viewModel.repoHtmlUrl) else { return  }
        webView.load(URLRequest(url: validUrl))
        webView.navigationDelegate = self
    }
}


//MARK:- WKWebview Delegates
extension RepositoryDetailController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator(show: true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(show: false)
    }
}
