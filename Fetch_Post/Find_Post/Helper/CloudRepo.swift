//
//  CloudRepo.swift
//  Find_Post
//
//  Created by Ankit Kumar on 29/04/24.
//

import UIKit
import CloudServices

/// Used to call the cloud service modules
protocol ICloudRepo {
    func getPostList(for query: String, completion: @escaping (Result<SearchResponse, ServiceError>) -> Void)
    func getComments(for query: String, completion: @escaping (Result<CommentResponse, ServiceError>) -> Void)
}

class CloudRepo: ICloudRepo {
    /// This is used for getting the repository list for the cloud module
    /// - Parameters:
    ///   - query: String for searching
    ///   - completion: closure with success and failure response
    func getPostList(for query: String, completion: @escaping (Result<SearchResponse, ServiceError>) -> Void ) {
        let service = SearchService()
        service.getPostList(for: query, completion: completion)
        // Only for testing purpose
//        completion(.success(MockResponse().getSearchSuccessResponse()))
    }

    func getComments(for query: String, completion: @escaping (Result<CommentResponse, ServiceError>) -> Void) {
        let service = CommentService()
        service.getCommentList(for: query, completion: completion)
    }
}

// MARK: - Remove this code - Only being used for testing purpose
fileprivate class MockResponse {
    let searchResponseSuccess = """
[
  {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
  },
  {
    "userId": 1,
    "id": 2,
    "title": "qui est esse",
    "body": "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
  },
  {
    "userId": 1,
    "id": 3,
    "title": "ea molestias quasi exercitationem repellat qui ipsa sit aut",
    "body": "et iusto sed quo iure\nvoluptatem occaecati omnis eligendi aut ad\nvoluptatem doloribus vel accusantium quis pariatur\nmolestiae porro eius odio et labore et velit aut"
  },
  {
    "userId": 1,
    "id": 4,
    "title": "eum et est occaecati",
    "body": "ullam et saepe reiciendis voluptatem adipisci\nsit amet autem assumenda provident rerum culpa\nquis hic commodi nesciunt rem tenetur doloremque ipsam iure\nquis sunt voluptatem rerum illo velit"
  },
  {
    "userId": 1,
    "id": 5,
    "title": "nesciunt quas odio",
    "body": "repudiandae veniam quaerat sunt sed\nalias aut fugiat sit autem sed est\nvoluptatem omnis possimus esse voluptatibus quis\nest aut tenetur dolor neque"
  },
  {
    "userId": 1,
    "id": 6,
    "title": "dolorem eum magni eos aperiam quia",
    "body": "ut aspernatur corporis harum nihil quis provident sequi\nmollitia nobis aliquid molestiae\nperspiciatis et ea nemo ab reprehenderit accusantium quas\nvoluptate dolores velit et doloremque molestiae"
  },
  {
    "userId": 1,
    "id": 7,
    "title": "magnam facilis autem",
    "body": "dolore placeat quibusdam ea quo vitae\nmagni quis enim qui quis quo nemo aut saepe\nquidem repellat excepturi ut quia\nsunt ut sequi eos ea sed quas"
  },
]
"""

    let searchResponseLimitExceed = """
{"message":"API rate limit exceeded for 122.161.50.239. (But here's the good news: Authenticated requests get a higher rate limit. Check out the documentation for more details.)","documentation_url":"https://docs.github.com/rest/overview/resources-in-the-rest-api#rate-limiting"}
"""
}

extension MockResponse {
    func getSearchSuccessResponse() -> SearchResponse {
        let data = searchResponseSuccess.data(using: .utf8)
        guard let expectedResponse = TestUtil.decodeSearchJSON(data: data) else {
            fatalError("Couldn't decode existing JSON string")
        }
        return expectedResponse
    }

    func getSearchRateLimitExceedResponse() -> SearchResponse {
        let data = searchResponseLimitExceed.data(using: .utf8)
        guard let expectedResponse = TestUtil.decodeSearchJSON(data: data) else {
            fatalError("Couldn't decode existing JSON string")
        }
        return expectedResponse
    }
}

fileprivate class TestUtil {
    static func decodeSearchJSON(data: Data?) -> SearchResponse? {
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(SearchResponse.self, from: data)
                return response
            } catch {
                return nil
            }
        }
        return nil
    }
}

