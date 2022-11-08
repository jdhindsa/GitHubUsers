//
//  CustomModifier.swift
//  GitHubUsers
//
//  Created by Jason Dhindsa on 2022-11-11.
//

import SwiftUI

struct GHUserCardTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .bold, design: .rounded))
    }
}

struct GHUserCardBioTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(4)
            .padding(.horizontal, 20)

    }
}
