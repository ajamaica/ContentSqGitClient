//
//  RepositoryProfleViewController.swift
//  GitHub Client
//
//  Created by Arturo Jamaica Garcia on 24/02/17.
//  Copyright © 2017 Arturo Jamaica. All rights reserved.
//

import UIKit
import SDWebImage

class RepositoryProfleViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let colors = [UIColor(red: 0.298, green: 0.686, blue: 0.314, alpha: 1.00),
                UIColor(red: 1.000, green: 0.439, blue: 0.263, alpha: 1.00),
                UIColor(red: 0.012, green: 0.663, blue: 0.957, alpha: 1.00),
                UIColor(red: 0.992, green: 0.847, blue: 0.208, alpha: 1.00),
                UIColor(red: 0.761, green: 0.094, blue: 0.357, alpha: 1.00)]
    let menus = ["Commits", "Contributors", "Issues", " Open Pull Request", "Branches"]
    
    @IBOutlet var label_branches: UILabel!
    @IBOutlet var label_forks: UILabel!
    @IBOutlet var label_commits: UILabel!
    @IBOutlet var img_avatar: UIImageView!
    @IBOutlet var label_owner: UILabel!
    @IBOutlet var label_name: UILabel!
    var repository: Repository?
    
    @IBOutlet var label_description: UILabel!
    @IBOutlet var label_stars: UILabel!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.label_name.text = self.repository?.name
        self.label_owner.text = "by \(self.repository!.owner.login)"
        self.label_description.text = "\(self.repository!.description!)"
        self.label_description.adjustsFontSizeToFitWidth = true
        self.label_description.numberOfLines = 2
        self.label_description.sizeToFit()
        
        if((self.repository!.forks_count) != nil){
            self.label_forks.text = "\(self.repository!.forks_count!) forks"

        }else{
            self.label_forks.text = "0 forks"
        }
        
        if((self.repository!.stargazers_count) != nil){
            self.label_stars.text = "\(self.repository!.stargazers_count!) stars"
            
        }else{
            self.label_stars.text = "0 stars"
        }
        
        self.img_avatar.sd_setImage(with: URL(string: self.repository!.owner.avatar_url!), placeholderImage: UIImage(named : "placeholder"))
        self.img_avatar.layer.cornerRadius = self.img_avatar.frame.size.width / 2
        self.img_avatar.clipsToBounds = true
        
        GitHubProvider.request(.repoCommits(self.repository!.full_name)) { result in
            
            if case let .success(response) = result {
                do {
                    
                    let repository = try response.mapArray() as [Commit]
                    print(repository)
                    self.label_commits.text = "\(repository.count) commits"
                } catch {

                }
            }
        }
        
        
        GitHubProvider.request(.repoBranches(self.repository!.full_name)) { result in
            
            if case let .success(response) = result {
                do {
                    
                    let repository = try response.mapArray() as [Branch]
                    print(repository)
                    self.label_branches.text = "\(repository.count) branches"
                } catch {
                    
                }
            }
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCellTableViewCell
        
        cell.backgroundColor = colors[indexPath.row]
        cell.label_menu_name.text = menus[indexPath.row]
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
