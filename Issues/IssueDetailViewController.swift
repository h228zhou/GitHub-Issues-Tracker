//
//  IssueDetailViewController.swift
//  Issues
//
//  Created by Ryan Zhou on 1/22/24.
//

import UIKit

class IssueDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var issueDetail: Issues?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let issue = issueDetail {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
            titleLabel.text = issue.title
            usernameLabel.text = "@\(issue.user.login)"
            dateLabel.text = DateFormatterHelper.formateDateString(issue.createdAt)
            bodyTextView.text = issue.body
            stateImageView.image = UIImage(systemName: issue.state=="open" ? "envelope.open" : "checkmark.square.fill")
            setupSafariButton()
        } else {
            titleLabel.isHidden = true
            usernameLabel.isHidden = true
            dateLabel.isHidden = true
            bodyTextView.isHidden = true
            stateImageView.isHidden = true
        }
    }
    
    private func setupSafariButton() {
        let safariButton = UIBarButtonItem(image: UIImage(systemName: "safari"), style: .plain, target: self, action: #selector(openInSafari))
        navigationItem.rightBarButtonItems = [safariButton]
    }
    
    @objc func openInSafari() {
        if let issue = issueDetail {
            if let url = URL(string: issue.htmlUrl), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "Can't open the issue in Safari because the URL is invalid.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true)
            }
        }
    }
    

}
