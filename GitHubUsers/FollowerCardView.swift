//
//  FollowerCardView.swift
//  GitHubUsers
//
//  Created by Jason Dhindsa on 2022-11-10.
//

import SwiftUI

struct FollowerCardView: View {
    var follower: Follower
    
    var body: some View {
        VStack {
            VStack {
                AsyncImage(url: URL(string: follower.avatarUrl)) { image in
                    image
                        .customImageModifier(width: 100, height: 100)
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100, alignment: .center)
                }
                Text(follower.login)
                    .modifier(GHUserCardTextModifier())
            }
        }
    }
}

struct FollowerCardView_Previews: PreviewProvider {
    static var previews: some View {
        let follower = Follower(
            login: "jdhindsa",
            avatarUrl: "https://avatars.githubusercontent.com/u/8378575?v=4"
        )
        FollowerCardView(follower: follower)
            .previewLayout(.fixed(width: 175, height: 175))
    }
}
