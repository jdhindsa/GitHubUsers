//
//  ContentView.swift
//  GitHubUsers
//
//  Created by Jason Dhindsa on 2022-11-08.
//

// Async Button Action:
// https://www.swiftbysundell.com/articles/building-an-async-swiftui-button/
// Programmatic Navigation Link:
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-programmatic-navigation-in-swiftui

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = GitHubUsersViewModel()
    @State private var username: String = ""
    @State private var followers = [Follower]()
    @State private var selection: String? = nil
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 60) {
                Spacer()
                Images.ghLogo
                    .customImageModifier(width: 300, height: 300)
                    .background(.white)
                TextField("Username", text: $username)
                    .frame(width: 350)
                    .textFieldStyle(.roundedBorder)
                AsyncButton(action: {
                    Task {
                        do {
                            followers = try await viewModel.manager.getFollowers(for: username, page: 1)
                            selection = followers.count > 0 ? NavigationTags.hasFollowers : NavigationTags.hasNoFollowers
                        } catch {
                            showingAlert = true
                        }
                    }
                }, label: {
                    Text("Search")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .frame(width: 325, height: 60)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(15.0)
                })
                .alert("\(username)\(Alerts.userNotFound)", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
                NavigationLink(
                    destination: FollowersView(followers: followers, username: username),
                    tag: NavigationTags.hasFollowers,
                    selection: $selection
                ) { EmptyView() }
                NavigationLink(
                    destination: NoFollowersView(),
                    tag: NavigationTags.hasNoFollowers,
                    selection: $selection
                ) { EmptyView() }
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
