//
//  FollowersView.swift
//  GitHubUsers
//
//  Created by Jason Dhindsa on 2022-11-09.
//

import SwiftUI

struct FollowersView: View {
    
    class SheetMananger: ObservableObject{
        
        enum Sheet{
            case UserDetailView
        }
        
        @Published var showSheet = false
        @Published var whichSheet: Sheet? = nil
    }
    
    @State var followers: [Follower]
    @State var username: String
    @State private var searchText = ""
    @State private var selectedFollowerUserName: String? = nil
    @State private var page: Int = 2
    @State private var showingAlert = false
    @StateObject private var sheetManager = SheetMananger()
    @StateObject private var viewModel = GitHubUsersViewModel()
    
    let columns = [
        GridItem(.flexible(minimum: 150, maximum: 175)),
        GridItem(.flexible(minimum: 150, maximum: 175)),
    ]
    
    var searchedFollowers: [Follower] {
        return searchText.isEmpty ? followers : followers.filter { $0.login.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(Array(zip(searchedFollowers.indices, searchedFollowers)), id: \.1) { index, follower in
                    FollowerCardView(follower: follower)
                        .onAppear {
                            if followers.count - 20 == index {
                                Task {
                                    do {
                                        followers += try await viewModel.manager.getFollowers(for: username, page: page)
                                        page += 1
                                    } catch {
                                        showingAlert = true
                                    }
                                }
                            }
                        }
                        .onTapGesture {
                            sheetManager.showSheet = true
                            sheetManager.whichSheet = .UserDetailView
                            selectedFollowerUserName = follower.login
                        }
                        .alert("Error encountered when followers were retrieved from server.", isPresented: $showingAlert) {
                            Button("OK", role: .cancel) { }
                        }
                }
            }
        }
        .searchable(text: $searchText)
        .sheet(isPresented: $sheetManager.showSheet) {
            if sheetManager.whichSheet == .UserDetailView {
                UserDetailView(userName: selectedFollowerUserName ?? "jdhindsa")
            }
        }
        .frame(maxHeight: .infinity)
    }
}

struct FollowersView_Previews: PreviewProvider {
    static var previews: some View {
        let followers: [Follower] = [
            Follower(login: "jdhindsa", avatarUrl: "https://avatars.githubusercontent.com/u/8378575?v=4"),
            Follower(login: "jdhindsa", avatarUrl: "https://avatars.githubusercontent.com/u/8378575?v=4"),
            Follower(login: "jdhindsa", avatarUrl: "https://avatars.githubusercontent.com/u/8378575?v=4"),
            Follower(login: "jdhindsa", avatarUrl: "https://avatars.githubusercontent.com/u/8378575?v=4"),
            Follower(login: "jdhindsa", avatarUrl: "https://avatars.githubusercontent.com/u/8378575?v=4"),
            Follower(login: "jdhindsa", avatarUrl: "https://avatars.githubusercontent.com/u/8378575?v=4"),
            Follower(login: "jdhindsa", avatarUrl: "https://avatars.githubusercontent.com/u/8378575?v=4"),
            Follower(login: "jdhindsa", avatarUrl: "https://avatars.githubusercontent.com/u/8378575?v=4"),
            Follower(login: "jdhindsa", avatarUrl: "https://avatars.githubusercontent.com/u/8378575?v=4"),
            Follower(login: "jdhindsa", avatarUrl: "https://avatars.githubusercontent.com/u/8378575?v=4"),
            Follower(login: "jdhindsa", avatarUrl: "https://avatars.githubusercontent.com/u/8378575?v=4"),
            Follower(login: "jdhindsa", avatarUrl: "https://avatars.githubusercontent.com/u/8378575?v=4")
        ]
        FollowersView(followers: followers, username: "jdhindsa")
    }
}
