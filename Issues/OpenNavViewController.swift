//
//  OpenNavViewController.swift
//  Issues
//
//  Created by Ryan Zhou on 1/22/24.
//

import UIKit

class OpenNavViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // https://developer.apple.com/documentation/uikit/uiimage/configuring_and_displaying_symbol_images_in_your_ui/
        tabBarItem = UITabBarItem(title: "Open", image: UIImage(systemName: "envelope.open"), tag: 1)

        // Do any additional setup after loading the view.
    }

}
