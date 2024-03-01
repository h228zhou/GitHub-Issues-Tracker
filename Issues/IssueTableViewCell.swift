//
//  IssueTableViewCell.swift
//  Issues
//
//  Created by Ryan Zhou on 1/22/24.
//

import UIKit

class IssueTableViewCell: UITableViewCell {
    @IBOutlet weak var closedUsernameLabel: UILabel!
    @IBOutlet weak var closedTitleLabel: UILabel!
    @IBOutlet weak var closedStateImageView: UIImageView!
    @IBOutlet weak var openUsernameLabel: UILabel!
    @IBOutlet weak var openTitleLabel: UILabel!
    @IBOutlet weak var openStateImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
