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
    }
    
    
    private func initTableView(){
        tableView.register(RespositoryListCell.nib, forCellReuseIdentifier: RespositoryListCell.identifier)
        tableView.dataSource = self
    }
    
    private func initViewModel(){
        viewModel.fetchInitialRepositories()
        
    }

   
}


extension RepositoryListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RespositoryListCell.identifier) as? RespositoryListCell else { return UITableViewCell()}
        return cell
    }
    
    
}
