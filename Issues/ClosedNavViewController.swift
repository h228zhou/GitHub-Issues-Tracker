//
//  ClosedNavViewController.swift
//  Issues
//
//  Created by Ryan Zhou on 1/22/24.
//

import UIKit

class ClosedNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem = UITabBarItem(title: "Closed", image: UIImage(systemName: "checkmark.square.fill"), tag: 1)

        // Do any additional setup after loading the view.
    }

}
