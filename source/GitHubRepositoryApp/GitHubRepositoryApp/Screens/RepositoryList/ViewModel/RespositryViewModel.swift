//
//  RespositryViewModel.swift
//  GitHubRepositoryApp
//
//  Created by Rajeswaran on 17/01/22.
//

import UIKit

final class RespositoryViewModel {
    
    var networkManager: NetworkManager
    
    let coordinator: RepositoryCoordinator
    
    private var repolist:[Item]?
    
    private var totalPages:Int = 0
    
    private var noOfDataPerPage = 10
    
    private var currentPage = 1
    
    var isPaginationOn = false
    
    var reloadTableView: (() -> Void)?
    
    var cellViewModel = [RepositoryCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    
    init(_ network: NetworkManager, coordinator: RepositoryCoordinator) {
        self.networkManager = network
        self.coordinator = coordinator
    }
    
}

extension RespositoryViewModel {
    
    private func parseToCellViewMolde(reponse:RepositoryResponse ) {
        guard let repositories = reponse.items else {
            self.coordinator.viewController.showAlert(message: reponse.message ?? "")
            return
        }
        self.repolist = repositories
        self.totalPages = reponse.totalCount ?? 0
        self.currentPage += 1
        var vms = [RepositoryCellViewModel]()
        for repo in repositories {
            if cellViewModel.count > 0 {
                if cellViewModel.contains(where: {$0.id != repo.idValue}) {
                    vms.append(createCellModel(repository: repo))
                }
                
            }else{
                vms.append(createCellModel(repository: repo))
            }
        }
        if cellViewModel.count == 0 {
            cellViewModel = vms
        }else{
            cellViewModel.append(contentsOf: vms)
        }
        
    }
    
    private func createCellModel(repository: Item) -> RepositoryCellViewModel {
        let id = repository.idValue
        let username = StringConstants.AuthorName + repository.owner.login
        let imageUrl = URL(string: repository.owner.avatarURL) ?? URL(string: "https://google.com")!
        let repoName = StringConstants.RepositoryName + repository.itemDescription
        let language = StringConstants.Language + (repository.language ?? "")
        let htmlUrl = repository.htmlURL
        
        return RepositoryCellViewModel(id: id, repoName: repoName, userImageUrl: imageUrl, language: language, authorName: username, htmlUrl: htmlUrl)
    }
    
    
    private var apiWithPaginationQuery: String{
        
        let queryItems = [URLQueryItem(name: "q", value:"ios"),URLQueryItem(name: "page", value:"\(currentPage)"), URLQueryItem(name: "per_page", value: "\(noOfDataPerPage)")]
        guard var urlComps = URLComponents(string: APIPath.searchios.url) else {return  APIPath.searchios.url}
        urlComps.queryItems = queryItems
        let result = urlComps.url?.absoluteString ?? APIPath.searchios.url
        return result
    }
    
    

    func fetchInitialRepositories(){
        if !NetworkReachability.isConnectedToNetwork(){
            self.coordinator.viewController.showAlert(message: StringConstants.NetworkConnectionError)
            return
            
        }
        isPaginationOn = true
        self.coordinator.viewController.view.showActivityIndicator()
        networkManager.fetchData(urlString: apiWithPaginationQuery) { [weak self] (result:Result<RepositoryResponse,Error>) in
            self?.isPaginationOn = false
            self?.coordinator.viewController.view.hideActivityIndicator()
            switch result {
            case .success(let responseModel):
                self?.parseToCellViewMolde(reponse: responseModel)
            case .failure(let failure):
                print(failure)
                self?.coordinator.viewController.showAlert(message: failure.localizedDescription)
                break
            }
        }
    }
    
    var noOfRepositories: Int {
        return cellViewModel.count
    }
    
    func noOfRowsCellViewModel(_ index:Int)-> RepositoryCellViewModel {
        return cellViewModel[index]
    }
    
    func repositorySelection(_ index: Int) {
        let repoDetails = cellViewModel[index]
        let vm = RepositoryDetailViewModel(repoHtmlUrl:repoDetails.htmlUrl, repoName: repoDetails.repoName)
        let vc = RepositoryDetailController(vm)
        self.coordinator.viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
}
