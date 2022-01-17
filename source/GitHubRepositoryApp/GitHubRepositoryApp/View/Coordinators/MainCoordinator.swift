//
//  MainCoordinator.swift
//  GitHubRepositoryApp
//
//  Created by Rajeswaran on 18/01/22.
//

import UIKit


protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}


class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
         let vc = RepositoryListController.loadFromNib()
        self.navigationController.pushViewController(vc, animated: false)
    
       
    }
}
