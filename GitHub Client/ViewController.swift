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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var repos = [Repository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getPublicRepos()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.cellForRow(at: indexPath)
        return cell!
    }
    func getPublicRepos() {
        
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
        GitHubProvider.request(.listRepositories()) { result in

            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)

            if case let .success(response) = result {
                
                do {
                    let repos_response = try response.mapArray() as [Repository]
                    self.repos = repos_response

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

