//
//  OpenIssuesTableViewController.swift
//  Issues
//
//  Created by Ryan Zhou on 1/22/24.
//

import UIKit

class OpenIssuesTableViewController: UITableViewController {
    
    let client = GithubClient()
    var issues: [Issues] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let openIssuesAppearance = UINavigationBarAppearance()
        openIssuesAppearance.backgroundColor = .red
        
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.standardAppearance = openIssuesAppearance
            navigationBar.scrollEdgeAppearance = openIssuesAppearance
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.refreshControl = refreshControl
        
        refreshData()
        
    }
    
    @objc func refreshData() {
        if !(self.refreshControl?.isRefreshing ?? false) {
            self.refreshControl?.beginRefreshing()
        }
        
        Task {
            do {
                issues = try await client.fetchIssues(state: "open")
                self.tableView.reloadData()
            } catch {
                print("Request failed with error: \(error)")
            }
            
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "openIssues", for: indexPath) as! IssueTableViewCell
        
        let issue = self.issues[indexPath.row]
        cell.openTitleLabel.text = issue.title
        cell.openUsernameLabel.text = "@\(issue.user.login)"
        cell.openTitleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        cell.openUsernameLabel.font = UIFont.systemFont(ofSize: 14)
        cell.openStateImageView.image = UIImage(systemName: issue.state=="open" ? "envelope.open" : "checkmark.square.fill")

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let issue = issues[indexPath.row]
        
        performSegue(withIdentifier: "openDetail", sender: issue)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openDetail",
           let destinationVC = segue.destination as? IssueDetailViewController,
           let issue = sender as? Issues{
            destinationVC.issueDetail = issue
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return issues.count
    }

}

