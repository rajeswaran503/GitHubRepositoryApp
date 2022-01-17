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
}
