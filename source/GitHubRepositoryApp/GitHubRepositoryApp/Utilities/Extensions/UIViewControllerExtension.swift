//
//  UIViewControllerExtension.swift
//  GitHubRepositoryApp
//
//  Created by Rajeswaran on 18/01/22.
//

import UIKit

extension UIViewController {
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: "\(message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self] action in
            self?.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}


extension UIView {
    func showActivityIndicator() {
        let container: UIView = UIView()
        container.tag = 222222
        let loadingView: UIView = UIView()
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        container.frame = self.frame
        container.center = self.center
        container.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = self.center
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame =  CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.color = .white
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        self.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    
    func hideActivityIndicator() {
        for sView in self.subviews where sView.tag == 222222 {
            sView.removeFromSuperview()
        }
    }
}
