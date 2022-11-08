//
//  GUError.swift
//  GitHubUsers
//
//  Created by Jason Dhindsa on 2022-11-08.
//

import Foundation

enum GUError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case invalidURL = "The URL we attempted to access for the data does not exist."
    case unableToComplete = "Unable to complete your request 🤯.  Please check your internet connection."
    case invalidResponse = "Invalid response from the server 😭, please try again."
    case invalidData = "The data received from the server is invalid.  Please try again."
    case unableToFavorite = "There was an error favoriting this user.  Please try again."
    case alreadyInFavorites = "You already favorited this user, you must REALLY like them!"
}
