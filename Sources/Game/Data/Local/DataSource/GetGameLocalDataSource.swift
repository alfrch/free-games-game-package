//
//  GetGameLocalDataSource.swift
//  Game
//
//  Created by Alif Rachmawan on 02/03/26.
//

import Foundation
import Core
import Combine
import RealmSwift

public struct GetGameLocalDataSource: LocalDataSource {
  
  public typealias Request = String
  public typealias Response = GameModuleEntity
  
  private let realm: Realm
  
  public init(realm: Realm) {
    self.realm = realm
  }
  
  public func list(request: Request?) -> AnyPublisher<[GameModuleEntity], Error> {
    fatalError()
  }
  
  public func add(entities: [GameModuleEntity]) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
  public func get(id: String) -> AnyPublisher<GameModuleEntity, Error> {
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
