//
//  UpdateFavoriteGameRepository.swift
//  Game
//
//  Created by Alif Rachmawan on 03/03/26.
//

import Foundation
import Core
import Combine

public struct UpdateFavoriteGameRepository<
  GameLocalDataSource: LocalDataSource,
  Transformer: Mapper
>: Repository where
GameLocalDataSource.Request == String,
GameLocalDataSource.Response == GameModuleEntity,
Transformer.Request == String,
Transformer.Response == GameResponse,
Transformer.Entity == GameModuleEntity,
Transformer.Domain == GameModel {
  
  public typealias Request = String
  public typealias Response = GameModel
  
  private let localDataSource: GameLocalDataSource
  private let mapper: Transformer
  
  public init(localDataSource: GameLocalDataSource, mapper: Transformer) {
    self.localDataSource = localDataSource
    self.mapper = mapper
  }
  
  public func execute(request: String?) -> AnyPublisher<GameModel, Error> {
    return localDataSource.get(id: request ?? "")
      .map { self.mapper.transformEntityToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }
}
