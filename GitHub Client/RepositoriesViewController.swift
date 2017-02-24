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
import PullToRefreshKit

class RepositoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating{

    
    var resultSearchController = UISearchController()
    @IBOutlet var tableView: UITableView!
    var repos_array = [Repository]()
    var search_repos_array = [Repository]()
    var search_request:Cancellable? = nil
    var publicActualScience = 0
    var searchActualPage = 1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        self.setUpTableView()
        getPublicRepos(since: publicActualScience)
    }
    
    
    // SETUP DESING, UI AND EVENTS TABLEVIEW
    
    func setUpTableView(){
        
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
        
        
        _ = self.tableView.setUpFooterRefresh {  [weak self] in
            
            if(self?.resultSearchController.isActive)!{
                
                self?.searchActualPage = (self?.searchActualPage)! + 1
                let search_query_txt = self?.resultSearchController.searchBar.text
                self?.searchPublicRepos(search_query: search_query_txt!,page: (self?.searchActualPage)!)
                
            }else{
                self?.getPublicRepos(since: (self?.publicActualScience)!)
            }
            
            }.SetUp { (footer) in
                
                footer.setText("Pull up to refresh", mode: RefreshKitFooterText.pullToRefresh)
                footer.setText("No more repos", mode: RefreshKitFooterText.noMoreData)
                footer.setText("Refreshing...", mode: RefreshKitFooterText.refreshing)
                footer.setText("Tap to load more", mode: RefreshKitFooterText.tapToRefresh)
                footer.setText("Scroll to load more", mode: RefreshKitFooterText.scrollAndTapToRefresh)
                
                footer.textLabel.textColor  = UIColor.black
                footer.refreshMode = .scrollAndTap
        }
        
        self.tableView.reloadData()

    }
    
    // MARK : UITableViewDelegate && UITableViewDataSource
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.resultSearchController.isActive = false
    }
    
    // MARK : UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        
        search_repos_array = [Repository]()
        self.tableView.reloadData()
        self.searchActualPage = 1
        
        searchPublicRepos(search_query: searchController.searchBar.text!,page: self.searchActualPage)
        
        
    }
    
    // MARK : API calls
    
    func searchPublicRepos(search_query : String, page : Int) {
        
        if(search_query.isEmpty){
            return
        }
        
        if(search_request != nil){
            search_request?.cancel()
        }
        
        search_request = GitHubProvider.request(.searchRepositories(search_query,page)) { result in
            
            if case let .success(response) = result {
                do {
                    
                    let repos_array_response = try response.mapArray(withKeyPath: "items") as [Repository]
                    // If page 1 create array is page 2 add to the list
                    if(self.searchActualPage > 1){
                        
                        self.search_repos_array = self.search_repos_array + repos_array_response
                        self.tableView.reloadData()
                        self.tableView.endFooterRefreshing()
                        
                    }else{
                        self.search_repos_array = repos_array_response
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    self.searchActualPage = self.searchActualPage - 1
                }
            }
        }
        
    }
    
    
    func getPublicRepos(since: Int) {
        
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
        GitHubProvider.request(.listRepositories(since)) { result in

            loadingNotification.hide(animated: true)
            
            if case let .success(response) = result {
                
                do {
                    
                    if(since == 0){
                        let repos_array_response = try response.mapArray() as [Repository]
                        let lastRepo = repos_array_response.last
                        self.publicActualScience = (lastRepo?.id)!
                        self.repos_array = repos_array_response
                        self.tableView.reloadData()
                    }else{
                        let repos_array_response = try response.mapArray() as [Repository]
                        self.repos_array = self.repos_array + repos_array_response
                        let lastRepo = repos_array_response.last
                        self.publicActualScience = (lastRepo?.id)!
                        self.tableView.reloadData()
                        self.tableView.endFooterRefreshing()
                    }
                    
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

