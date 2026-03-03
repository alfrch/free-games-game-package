//
//  Untitled.swift
//  Game
//
//  Created by Alif Rachmawan on 02/03/26.
//

import Core
import Combine

public struct GetFavoriteGamesRepository<
  GamesLocalDataSource: LocalDataSource,
  Transformer: Mapper
>: Repository
where
GamesLocalDataSource.Request == String,
GamesLocalDataSource.Response == GameModuleEntity,
Transformer.Request == String,
Transformer.Response == [GameResponse],
Transformer.Entity == [GameModuleEntity],
Transformer.Domain == [GameModel] {
  
  public typealias Request = String
  public typealias Response = [GameModel]
  
  private let localDatasource: GamesLocalDataSource
  private let mapper: Transformer
  
  public init(
    localDatasource: GamesLocalDataSource,
    mapper: Transformer
  ) {
    self.localDatasource = localDatasource
    self.mapper = mapper
  }
  
  public func execute(request: String?) -> AnyPublisher<[GameModel], any Error> {
    return self.localDatasource.list(request: request)
      .map { self.mapper.transformEntityToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }
}
