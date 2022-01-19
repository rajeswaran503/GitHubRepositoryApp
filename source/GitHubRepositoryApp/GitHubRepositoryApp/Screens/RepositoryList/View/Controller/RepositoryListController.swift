//
//  RepositoryListController.swift
//  GitHubRepositoryApp
//
//  Created by Rajeswaran on 06/01/22.
//

import UIKit

class RepositoryListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    lazy var viewModel = {
        RespositoryViewModel(NetworkManager(), coordinator: RepositoryCoordinator(self))
    }()
    
    var repoCoordinator:RepositoryCoordinator!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initTableView()
        initViewModel()
        self.title = StringConstants.HomeTitle        
    }
    
    
    private func initTableView(){
        tableView.register(RespositoryListCell.nib, forCellReuseIdentifier: RespositoryListCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    private func initViewModel(){
        viewModel.fetchInitialRepositories()
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
    
    
}

//MARK:- TableView Data source
extension RepositoryListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.noOfRepositories
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RespositoryListCell.identifier) as? RespositoryListCell else { return UITableViewCell()}
        cell.cellViewModel = viewModel.noOfRowsCellViewModel(indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
}


//MARK:- TableView Delegate
extension RepositoryListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.repositorySelection(indexPath.row)
    }
}

//MARK:- ScrollView Delegate
extension RepositoryListController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.y
        if pos > tableView.contentSize.height-50 - scrollView.frame.size.height{
            guard !viewModel.isPaginationOn else{
                return
            }
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
            viewModel.fetchInitialRepositories()
            
        }
    }
}
