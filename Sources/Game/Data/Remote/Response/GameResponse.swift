//
//  GameResponse.swift
//  Game
//
//  Created by Alif Rachmawan on 26/02/26.
//

import Foundation

public struct GameResponse: Decodable, Sendable {
  let id: Int?
  let title: String?
  let worth: String?
  let thumbnail: String?
  let description: String?
  let type: String?
  let platforms: String?
  let url: String?
  
  private enum CodingKeys: String, CodingKey {
    case id,
         title,
         worth,
         thumbnail,
         description,
         type,
         platforms
    case url = "gamerpower_url"
  }
}
