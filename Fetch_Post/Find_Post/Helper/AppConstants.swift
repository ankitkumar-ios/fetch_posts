//
//  AppConstants.swift
//  Find_Post
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
import CloudServices

struct AppConstants {
    static let ID = "ID: "
    static let userID = "User ID: "
    static let searchPlaceholder = "Fetch Post"
    static let fetchingData = "Fetching data"
    static let empty = ""
    static let space = " "
    static let matchingResults = "matching results"
    static let dashboard = "Dashboard"
    static let kb = "KB"
    static let startFetchingPost = "Fetch posts by pressing the top button"
    static let gettingNewResults = "Getting new results"

    static let titleError = "Error"
    static let noInternetConnection = "No Internet, please turn on wifi or mobile network"
    static let badData = "Could not parse cloud JSON"
    static let invalidUrl = "It's not you it's us. We found that the cloud URL is invalid"
    static let couldNotFindData = "None of the search qualifiers apply to this search type."

    static let badRequest = "Bad request"
    static let unauthorized = "Request is unauthorized"
    static let forbidden = "API rate limit exceeded (But here's the good news: Authenticated requests get a higher rate limit. Check out the documentation for more details.)"
    static let notFound = "Reuqest not found"
    static let internalServiceError = "Internal service error"

    static func responseError(code: HTTPStatusCode) -> String {
        return "Getting error code \(code)"
    }
    static func error(error: Error) -> String {
        return "Got error: \(error.localizedDescription)"
    }
}
