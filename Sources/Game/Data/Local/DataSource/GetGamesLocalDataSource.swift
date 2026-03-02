//
//  GetGamesLocalDataSource.swift
//  Game
//
//  Created by Alif Rachmawan on 26/02/26.
//

import Foundation
import Core
import Combine
import RealmSwift

public struct GetGamesLocalDataSource: LocalDataSource {
  
  public typealias Request = Any
  public typealias Response = GameModuleEntity
  
  private let realm: Realm
  
  public init(realm: Realm) {
    self.realm = realm
  }
  
  public func list(request: Request?) -> AnyPublisher<[GameModuleEntity], Error> {
    return Future<[GameModuleEntity], Error> { completion in
      let gameEntities: Results<GameModuleEntity> = {
        self.realm.objects(GameModuleEntity.self)
          .sorted(by: \.title)
      }()
      completion(.success(gameEntities.toArray(ofType: GameModuleEntity.self)))
    }
    .eraseToAnyPublisher()
  }
  
  public func add(entities: [GameModuleEntity]) -> AnyPublisher<Bool, any Error> {
    return Future<Bool, Error> { completion in
      do {
        try self.realm.write {
          self.realm.add(entities, update: .all)
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }
    .eraseToAnyPublisher()
  }
  
  public func get(id: String) -> AnyPublisher<GameModuleEntity, any Error> {
    Future<GameModuleEntity, Error> { completion in
      let games: Results<GameModuleEntity> = {
        realm.objects(GameModuleEntity.self)
          .filter("id = '\(id)'")
      }()
      
      guard let game = games.first else {
        completion(.failure(DatabaseError.requestFailed))
        return
      }
      
      completion(.success(game))
    }
    .eraseToAnyPublisher()
  }
  
  public func update(id: Int, entity: GameModuleEntity) -> AnyPublisher<Bool, any Error> {
    fatalError()
  }
}
