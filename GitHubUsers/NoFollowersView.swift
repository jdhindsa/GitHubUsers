//
//  NoFollowersView.swift
//  GitHubUsers
//
//  Created by Jason Dhindsa on 2022-11-09.
//

import SwiftUI

struct NoFollowersView: View {
    var body: some View {
        VStack(spacing: 10) {
            GeometryReader { geometry in
                Spacer()
                Text("This user has no followers ☹️.  Go ahead and follow them!")
                    .frame(width: geometry.size.width - 30, height: 100, alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .padding(.horizontal, 16)
                Images.emptyStateLogo
                    .customImageModifier(width: 800, height: 800)
                    .offset(y: 150)
            }
        }
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        NoFollowersView()
    }
}
