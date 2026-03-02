//
//  GameTransformer.swift
//  Game
//
//  Created by Alif Rachmawan on 26/02/26.
//

import Core

public struct GameTransformer: Mapper {
  public typealias Request = Any
  public typealias Response = [GameResponse]
  public typealias Entity = [GameModuleEntity]
  public typealias Domain = [GameModel]
  
  public init() {}
  
  public func transformResponseToEntity(request: Any?, response: [GameResponse]) -> [GameModuleEntity] {
    return response.map { result in
      let gameEntity = GameModuleEntity()
      gameEntity.id = "\(result.id ?? 0)"
      gameEntity.title = result.title ?? "Unknown Title"
      gameEntity.price = result.worth ?? "N/A"
      gameEntity.thumbnail = result.thumbnail ?? ""
      gameEntity.desc = result.description ?? "No description available"
      gameEntity.type = result.type ?? "Unknown"
      
      let platformArray = result.platforms?.components(separatedBy: ", ") ?? []
      gameEntity.platforms.removeAll()
      gameEntity.platforms.append(objectsIn: platformArray)
      return gameEntity
    }
  }
  
  public func transformEntityToDomain(entity: [GameModuleEntity]) -> [GameModel] {
    return entity.map { result in
      return GameModel(
        id: Int(result.id) ?? 0,
        title: result.title,
        price: result.price,
        thumbnail: result.thumbnail,
        description: result.desc,
        type: result.type,
        platforms: Array(result.platforms),
        url: result.url,
        favorite: result.favorite
      )
    }
  }
}
