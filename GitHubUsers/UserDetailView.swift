//
//  UserDetailView.swift
//  GitHubUsers
//
//  Created by Jason Dhindsa on 2022-11-12.
//

import SwiftUI

struct UserDetailView: View {
    @State var userName: String
    @State private var user: User?
    @State private var fetchUserTask: Task<(), Never>? = nil
    @StateObject private var viewModel = GitHubUsersViewModel()
    
    var body: some View {
        VStack {
            if let user = user {
                UserMemberInfoDetailView(
                    avatarUrl: user.avatarUrl,
                    name: user.name ?? "N/A",
                    login: user.login,
                    memberSince: user.createdAt
                )
                
                VStack(alignment: .leading, spacing: 12) {
                    Divider()
                    UserGitHubWebsiteAndLocationView(
                        htmlUrl: user.htmlUrl,
                        location: user.location ?? "No location provided"
                    )
                    Divider()
                    UserMemberBioDetailView(bio: user.bio ?? "No bio provided.")
                    Divider()
                    UserMemberStatsDetailView(
                        publicGists: user.publicGists,
                        publicRepos: user.publicRepos,
                        followers: user.followers,
                        following: user.following
                    )
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                
                Spacer()
            }
        }
        .onDisappear {
            fetchUserTask?.cancel()
        }
        .onAppear {
            fetchUserTask = Task {
                do {
                    user = try await viewModel.manager.getUser(for: userName)
                } catch {
                    user = nil
                }
            }
        }
    }
}

struct UserMemberInfoDetailView: View {
    var avatarUrl: String
    var name: String
    var login: String
    var memberSince: Date
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: avatarUrl)) { image in
                    image
                        .customCircularImageModifier(width: 125, height: 125, radius: 10)
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100, alignment: .center)
                }
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("Name: \(name)")
                Text("User Name: \(login)")
                Text("Member Since: \(memberSince.convertToMonthYearFormat())")
            }
            .font(.system(size: 13, weight: .regular, design: .rounded))
        }
        .padding(.vertical, 16)
    }
}

struct UserMemberBioDetailView: View {
    var bio: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("BIO")
            }
            .font(.system(size: 15, weight: .bold, design: .rounded))
            .padding(.horizontal, 8)
            Text("\(bio)")
                .padding(.horizontal, 8)
                .padding(.top, 8)
                .font(.system(size: 13, weight: .regular, design: .rounded))
                .multilineTextAlignment(.leading)
                .lineLimit(5)
        }
    }
}

struct UserMemberStatsDetailView: View {
    var publicGists: Int
    var publicRepos: Int
    var followers: Int
    var following: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Public Gists")
                Spacer()
                Text("\(publicGists)")
                    .padding(.trailing, 100)
            }
            .font(.system(size: 13, weight: .regular, design: .rounded))
            
            HStack {
                Text("Public Repos")
                Spacer()
                Text("\(publicRepos)")
                    .padding(.trailing, 100)
            }
            .font(.system(size: 13, weight: .regular, design: .rounded))
            
            HStack {
                Text("Followers")
                Spacer()
                Text("\(followers)")
                    .padding(.trailing, 100)
            }
            .font(.system(size: 13, weight: .regular, design: .rounded))
            
            HStack {
                Text("Following")
                Spacer()
                Text("\(following)")
                    .padding(.trailing, 100)
            }
            .font(.system(size: 13, weight: .regular, design: .rounded))
        }
        .padding(.horizontal, 8)
    }
}

struct UserGitHubWebsiteAndLocationView: View {
    var htmlUrl: String
    var location: String
    
    var body: some View {
        VStack {
            HStack {
                Link(destination: URL(string: htmlUrl)!) {
                    Image(systemName: "network")
                        .font(Font.system(.title2).bold())
                    Text("\(htmlUrl)")
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                }
                Spacer()
            }
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .font(Font.system(.title2).bold())
                Text("\(location)")
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                Spacer()
            }
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(userName: "jdhindsa")
    }
}
