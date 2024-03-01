//
//  ClosedIssuesTableViewController.swift
//  Issues
//
//  Created by Ryan Zhou on 1/22/24.
//

import UIKit

class ClosedIssuesTableViewController: UITableViewController {
    
    let client = GithubClient()
    var issues: [Issues] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let closedIssuesAppearance = UINavigationBarAppearance()
        closedIssuesAppearance.backgroundColor = .green
        
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.standardAppearance = closedIssuesAppearance
            navigationBar.scrollEdgeAppearance = closedIssuesAppearance
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
                issues = try await client.fetchIssues(state: "closed")
                self.tableView.reloadData()
            } catch {
                print("Request failed with error: \(error)")
            }
            
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "closedIssues", for: indexPath) as! IssueTableViewCell

        let issue = issues[indexPath.row]
        
        cell.closedTitleLabel.text = issue.title
        cell.closedUsernameLabel.text = "@\(issue.user)"
        
        cell.closedTitleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        cell.closedUsernameLabel.font = UIFont.systemFont(ofSize: 14)
        
        cell.closedStateImageView.image = UIImage(systemName: issue.state=="open" ? "envelope.open" : "checkmark.square.fill")

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let issue = issues[indexPath.row]
        
        performSegue(withIdentifier: "closedDetail", sender: issue)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "closedDetail",
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
