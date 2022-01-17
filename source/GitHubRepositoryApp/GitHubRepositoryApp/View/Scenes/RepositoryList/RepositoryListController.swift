//
//  RepositoryListController.swift
//  GitHubRepositoryApp
//
//  Created by Rajeswaran on 06/01/22.
//

import UIKit

class RepositoryListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel:RespositoryViewModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       registerCells()
        viewModel = RespositoryViewModel(NetworkManager(), coordinator: RepositoryCoordinator.vi(Self))
    }

    private func registerCells(){
        tableView.register(UINib(nibName: "\(RespositoryListCell.self)", bundle: .main), forCellReuseIdentifier: RespositoryListCell.identifier)
        tableView.dataSource = self
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
