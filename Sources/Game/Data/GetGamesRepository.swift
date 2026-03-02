//
//  GetGamesRepository.swift
//  Game
//
//  Created by Alif Rachmawan on 26/02/26.
//

import Core
import Combine

public struct GetGamesRepository<
  GameLocalDataSource: LocalDataSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper
>: Repository where
GameLocalDataSource.Response == GameModuleEntity,
RemoteDataSource.Response == [GameResponse],
Transformer.Response == [GameResponse],
Transformer.Entity == [GameModuleEntity],
Transformer.Domain == [GameModel] {
  
  public typealias Request = Any
  public typealias Response = [GameModel]
  
  private let localDataSource: GameLocalDataSource
  private let remoteDataSource: RemoteDataSource
  private let mapper: Transformer
  
  public init(
    localDataSource: GameLocalDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer
  ) {
    self.localDataSource = localDataSource
    self.remoteDataSource = remoteDataSource
    self.mapper = mapper
  }
  
  public func execute(request: Any?) -> AnyPublisher<[GameModel], Error> {
    return self.localDataSource.list(request: nil)
      .flatMap { result -> AnyPublisher<[GameModel], Error> in
        if result.isEmpty {
          return self.remoteDataSource.execute(request: nil)
            .map { self.mapper.transformResponseToEntity(request: nil, response: $0) }
            .catch { _ in self.localDataSource.list(request: nil) }
            .flatMap { self.localDataSource.add(entities: $0) }
            .flatMap { _ in self.localDataSource.list(request: nil) }
            .map { self.mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        } else {
          return self.localDataSource.list(request: nil)
            .map { self.mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
      }
      .eraseToAnyPublisher()
  }
  
}
