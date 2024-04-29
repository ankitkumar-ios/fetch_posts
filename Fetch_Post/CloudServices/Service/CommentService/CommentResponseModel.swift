//
//  CommentResponseModel.swift
//  CloudServices
//
//  Created by Ankit Kumar on 29/04/24.
//

import Foundation

/// CommentResponse model helps to decode API values
public struct CommentResponse: Decodable {
    /// Just to make the initializer public
    public init() {}

    /// List of Countries and it's rates for 1USD
    public var items: [CommentItem]?

    /// Initialising from decoder to decode JSON
    /// - Parameter decoder: Decoder
    public init(from decoder: Decoder) throws {
        let values = try decoder.singleValueContainer()
        items = try values.decode([CommentItem].self)
    }
}
/// SearchResponse model helps to decode API values
public struct CommentItem: Codable {
    /// Just to make the initializer public
    public init() {}

    public var postId : Int?
    public var id : Int?
    public var name : String?
    public var email : String?
    public var body : String?

    enum CodingKeys: String, CodingKey {
        case postId, id, name, email, body
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        postId = try values.decodeIfPresent(Int.self, forKey: .postId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        body = try values.decodeIfPresent(String.self, forKey: .body)
    }
}
