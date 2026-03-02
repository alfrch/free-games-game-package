//
//  GetFavoriteGamesLocalDataSource.swift
//  Game
//
//  Created by Alif Rachmawan on 02/03/26.
//

import Foundation
import Core
import Combine
import RealmSwift

public struct GetFavoriteGamesLocalDataSource: LocalDataSource {
  
  public typealias Request = String
  public typealias Response = GameModuleEntity
  
  private let realm: Realm?
  
  public init(realm: Realm?) {
    self.realm = realm
  }
  
  public func list(request: String?) -> AnyPublisher<[GameModuleEntity], any Error> {
    return Future<[GameModuleEntity], Error> { completion in
      if let realm = self.realm {
        let gameEntities = {
          realm.objects(GameModuleEntity.self)
            .filter("favorite = \(true)")
            .sorted(byKeyPath: "title", ascending: true)
        }()
        completion(.success(gameEntities.toArray(ofType: GameModuleEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }
    .eraseToAnyPublisher()
  }
  
  public func add(entities: [GameModuleEntity]) -> AnyPublisher<Bool, any Error> {
    fatalError()
  }
  
  public func get(id: String) -> AnyPublisher<GameModuleEntity, any Error> {
    fatalError()
  }
  
  public func update(id: Int, entity: GameModuleEntity) -> AnyPublisher<Bool, any Error> {
    fatalError()
  }
}
