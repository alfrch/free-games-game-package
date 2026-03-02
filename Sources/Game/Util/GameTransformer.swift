//
//  GameTransformer.swift
//  Game
//
//  Created by Alif Rachmawan on 02/03/26.
//

import Foundation
import Core

public struct GameTransformer: Mapper {
  
  public typealias Request = Any
  public typealias Response = GameResponse
  public typealias Entity = GameModuleEntity
  public typealias Domain = GameModel
  
  public init() {}
  
  public func transformResponseToEntity(request: Request?, response: GameResponse) -> GameModuleEntity {
    let gameEntity = GameModuleEntity()
    gameEntity.id = UUID().uuidString
    gameEntity.title = "Unknown Title"
    gameEntity.price = "N/A"
    gameEntity.thumbnail = ""
    gameEntity.desc = "No description available"
    gameEntity.type = "Unknown"
    
    let platformArray = [""]
    gameEntity.platforms.removeAll()
    gameEntity.platforms.append(objectsIn: platformArray)
    return gameEntity
  }
  
  public func transformEntityToDomain(entity: GameModuleEntity) -> GameModel {
    return GameModel(
      id: Int(entity.id) ?? 0,
      title: entity.title,
      price: entity.price,
      thumbnail: entity.thumbnail,
      description: entity.desc,
      type: entity.type,
      platforms: Array(entity.platforms),
      url: entity.url,
      favorite: entity.favorite
    )
  }
}
