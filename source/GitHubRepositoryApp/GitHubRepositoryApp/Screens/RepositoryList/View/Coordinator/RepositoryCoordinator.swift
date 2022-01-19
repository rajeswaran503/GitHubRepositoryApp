//
//  RepositoryCoordinator.swift
//  GitHubRepositoryApp
//
//  Created by Rajeswaran on 18/01/22.
//

import UIKit


protocol RepositoryCoordinatorProtocol: AnyObject {
    var viewController:UIViewController {get set}
}

class RepositoryCoordinator:  RepositoryCoordinatorProtocol{
    var viewController: UIViewController
    init(_ controller: UIViewController) {
        self.viewController = controller
    }
}
