//
//  Issues.swift
//  Issues
//
//  Created by Ryan Zhou on 1/22/24.
//

import Foundation

struct Issues: Codable {
    let title: String?
    let createdAt: String
    let body: String?
    let state: String
    let user: GithubUser
    let htmlUrl: String
}
