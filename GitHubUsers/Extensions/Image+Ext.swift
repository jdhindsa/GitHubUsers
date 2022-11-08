//
//  Image+Ext.swift
//  GitHubUsers
//
//  Created by Jason Dhindsa on 2022-11-11.
//

import UIKit
import SwiftUI

extension Image {
    func customImageModifier(width: CGFloat, height: CGFloat) -> some View {
        return self
            .renderingMode(.original)
            .resizable()
            .frame(width: width, height: height, alignment: .center)
            .scaledToFit()
   }
    
    func customCircularImageModifier(width: CGFloat, height: CGFloat, radius: CGFloat) -> some View {
        return self
            .renderingMode(.original)
            .resizable()
            .frame(width: width, height: height, alignment: .center)
            .clipShape(Circle())
            .shadow(radius: radius)
            .scaledToFit()
    }
}
