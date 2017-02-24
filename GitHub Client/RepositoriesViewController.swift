//
//  ViewController.swift
//  GitHub Client
//
//  Created by Arturo Jamaica Garcia on 23/02/17.
//  Copyright © 2017 Arturo Jamaica. All rights reserved.
//

import UIKit
import Moya_ModelMapper
import Mapper
import MBProgressHUD

class RepositoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var repos_array = [Repository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getPublicRepos()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repos_array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let repo = repos_array[indexPath.row]
        
        let cell  = self.tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as! RepoTableViewCell
        cell.name.text = repo.name
        return cell
        
    }
    func getPublicRepos() {
        
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
        GitHubProvider.request(.listRepositories()) { result in

            loadingNotification.hide(animated: true)
            
            if case let .success(response) = result {
                
                do {
                    let repos_array_response = try response.mapArray() as [Repository]
                    self.repos_array = repos_array_response
                    self.tableView.reloadData()
                } catch {

                }
            }
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

