//
//  Utilities.swift
//  GitHubUsers
//
//  Created by Jason Dhindsa on 2022-11-09.
//

import SwiftUI

enum Images {
    static let ghLogo = Image("github-logo")
    static let emptyStateLogo = Image("empty-state-logo")
    static let avatarPlaceholder = Image("avatar-placeholder")
}

enum NavigationTags {
    static let hasNoFollowers = "A"
    static let hasFollowers = "B"
}

enum Labels {
    static let bio = "Bio"
    static let following = "Following"
    static let followers = "Followers"
    static let publicGists = "Public Gists"
    static let publicRepos = "Public Repos"
    static let memberSince = "Joined: "
    static let noBioProvided = "User did not provide a bio."
    static let notApplicable = "N/A"
}

enum Alerts {
    static let userNotFound = " is not a user on GitHub!"
}
