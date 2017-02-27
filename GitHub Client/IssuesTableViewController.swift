//
//  IssuesTableViewController.swift
//  GitHub Client
//
//  Created by Arturo Jamaica Garcia on 27/02/17.
//  Copyright © 2017 Arturo Jamaica. All rights reserved.
//

import UIKit
import MBProgressHUD

class IssuesTableViewController: UITableViewController {

    var repository: Repository?
    var issues:[Issue] = [Issue]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 119.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        getIssues()
    }
    
    func getIssues(){
        
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
        GitHubProvider.request(.repoIssues(self.repository!.full_name)) { result in
            
            if case let .success(response) = result {
                do {
                    loadingNotification.hide(animated: true)
                    let issues_array = try response.mapArray() as [Issue]
                    self.issues = issues_array
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let issue = issues[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssueTableViewCell", for: indexPath) as! IssueTableViewCell
        cell.label_autor.text = "by \(issue.user.login)"
        cell.label_title.text = issue.title
        cell.tableview_description.text = issue.body
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
