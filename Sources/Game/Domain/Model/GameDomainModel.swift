//
//  GameDomainModel.swift
//  Game
//
//  Created by Alif Rachmawan on 26/02/26.
//

import Foundation

public struct GameModel: Identifiable, Equatable {
  public let id: Int
  public let title: String
  public let price: String
  public let thumbnail: String
  public let description: String
  public let type: String
  public let platforms: [String]
  public let url: String
  public var favorite: Bool
  
  public init(
    id: Int,
    title: String,
    price: String,
    thumbnail: String,
    description: String,
    type: String,
    platforms: [String],
    url: String,
    favorite: Bool = false) {
    self.id = id
    self.title = title
    self.price = price
    self.thumbnail = thumbnail
    self.description = description
    self.type = type
    self.platforms = platforms
    self.url = url
    self.favorite = favorite
  }
}
