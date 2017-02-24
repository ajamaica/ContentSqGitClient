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
import Moya

class RepositoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating {

    var resultSearchController = UISearchController()
    @IBOutlet var tableView: UITableView!
    var repos_array = [Repository]()
    var search_repos_array = [Repository]()
    var search_request:Cancellable? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.barStyle = UIBarStyle.black
            controller.searchBar.barTintColor = UIColor.white
            controller.searchBar.backgroundColor = UIColor.clear
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        self.tableView.reloadData()
        getPublicRepos()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(self.resultSearchController.isActive){
            return self.search_repos_array.count
        }else{
            return self.repos_array.count
        }
        
    }
    
  
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var repo:Repository?  = nil
            
        if(self.resultSearchController.isActive){
             repo = search_repos_array[indexPath.row]
        }else{
            repo = repos_array[indexPath.row]
        }
        
        let cell  = self.tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as! RepoTableViewCell
        cell.label_name.text = repo?.name
        cell.label_owner.text = repo?.owner.login
        return cell
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        searchPublicRepos(search_query: searchController.searchBar.text!)
        self.tableView.reloadData()

    }
    

    
    func searchPublicRepos(search_query : String) {
        
        if(search_request != nil){
            search_request?.cancel()
        }
        
        search_request = GitHubProvider.request(.searchRepositories(search_query)) { result in
            if case let .success(response) = result {
                do {
                    
                    let repos_array_response = try response.mapArray(withKeyPath: "items") as [Repository]
                    self.search_repos_array = repos_array_response
                    self.tableView.reloadData()
                    
                } catch {
                    
                }
            }
        }
        
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

