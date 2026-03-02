//
//  GameModuleEntity.swift
//  Game
//
//  Created by Alif Rachmawan on 26/02/26.
//

import Foundation
import RealmSwift

public class GameModuleEntity: Object {
  @objc dynamic var id = ""
  @objc dynamic var title = ""
  @objc dynamic var price = ""
  @objc dynamic var thumbnail = ""
  @objc dynamic var desc = ""
  @objc dynamic var type = ""
  @objc dynamic var url = ""
  @objc dynamic var favorite: Bool = false
  
  let platforms = List<String>()
  
  public override nonisolated static func primaryKey() -> String? {
    return "id"
  }
}
