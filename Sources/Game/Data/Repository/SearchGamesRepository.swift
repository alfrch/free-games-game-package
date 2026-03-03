//
//  SearchGamesRepository.swift
//  Game
//
//  Created by Alif Rachmawan on 03/03/26.
//

import Core
import Combine

public struct SearchGamesRepository<
  GameLocalDataSource: LocalDataSource,
  Transformer: Mapper
>: Repository where
GameLocalDataSource.Request == String,
GameLocalDataSource.Response == GameModuleEntity,
Transformer.Response == [GameResponse],
Transformer.Entity == [GameModuleEntity],
Transformer.Domain == [GameModel] {
  
  public typealias Request = String
  public typealias Response = [GameModel]
  
  private let localDataSource: GameLocalDataSource
  private let mapper: Transformer
  
  public init(
    localDataSource: GameLocalDataSource,
    mapper: Transformer
  ) {
    self.localDataSource = localDataSource
    self.mapper = mapper
  }
  
  public func execute(request: String?) -> AnyPublisher<[GameModel], any Error> {
    localDataSource.list(request: request)
      .map { self.mapper.transformEntityToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }
}
