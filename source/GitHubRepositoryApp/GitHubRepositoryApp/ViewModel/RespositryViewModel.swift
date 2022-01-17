//
//  RespositryViewModel.swift
//  GitHubRepositoryApp
//
//  Created by Rajeswaran on 17/01/22.
//

import UIKit

protocol RepositoryCoordinator: AnyObject {
    var viewController:UIViewController {get set}
}

final class RespositoryViewModel {
    
    unowned let networkManager: NetworkManager
    
    unowned let coordinator: RepositoryCoordinator
    
    private var repolist:[Item]?
    
    private var totalPages:Int = 0
    
    
    init(_ network: NetworkManager, coordinator: RepositoryCoordinator) {
        self.networkManager = network
        self.coordinator = coordinator
    }
    
}

extension RespositoryViewModel {
    func fetchInitialRepositories(){
        networkManager.fetchData(urlString: APIPath.searchios.url) { [weak self] (result:Result<RepositoryResponse,Error>) in
            switch result {
            case .success(let responseModel):
                self?.repolist = responseModel.items
                self?.totalPages = responseModel.totalCount
                
            case .failure(let failure):
                break
            }
        }
    }
    
    func fetchNextPageRepositories(){
        
    }
    
    var noOfRepositories: Int {
        guard let value = repolist else { return 0 }
        return value.count
    }
    
    func noOfRowsRepository(_ index:Int)-> Item? {
        guard let value = repolist else { return nil }
        return value[index]
    }
    
}
