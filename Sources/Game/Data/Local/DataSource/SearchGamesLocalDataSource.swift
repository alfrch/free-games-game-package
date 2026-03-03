//
//  SearchGamesLocalDataSource.swift
//  Game
//
//  Created by Alif Rachmawan on 03/03/26.
//

import Foundation
import Core
import Combine
import RealmSwift

public struct SearchGamesLocalDataSource: LocalDataSource {
  
  public typealias Request = String
  public typealias Response = GameModuleEntity
  
  private let realm: Realm
  
  public init(realm: Realm) {
    self.realm = realm
  }
  
  public func list(request: String?) -> AnyPublisher<[GameModuleEntity], any Error> {
    Future<[GameModuleEntity], Error> { completion in
      let gameEntities = {
        realm.objects(GameModuleEntity.self)
          .filter("title contains[c] %@", request ?? "")
          .sorted(byKeyPath: "title", ascending: true)
      }()
      completion(.success(gameEntities.toArray(ofType: GameModuleEntity.self)))
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
