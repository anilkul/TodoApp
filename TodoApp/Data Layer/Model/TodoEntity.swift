//
//  TodoEntity.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation
import CoreData

// Entity here that conforms Decodable protocol may seem like Interface Segregation but I wanted to show that this could be used in network layer in future.
class TodoEntity: NSManagedObject, Decodable {
  enum CodingKeys: CodingKey {
    case title, detail, completionDate
  }
  
  required convenience init(from decoder: Decoder) throws {
    guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
      throw DecoderConfigurationError.missingManagedObjectContext
    }
    
    self.init(context: context)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.title = try container.decode(String.self, forKey: .title)
    self.detail = try container.decode(String.self, forKey: .detail)
    self.completionDate = try container.decode(Double.self, forKey: .completionDate)
  }
}

extension TodoEntity {
  func assignValues(from item: TodoItem) {
    self.title = item.title
    self.detail = item.detail
    self.completionDate = item.completionDate
  }
}

extension TodoEntity {
  var todoItem: TodoItem? {
    guard let title = title else { return nil }
    return TodoItem(title: title, detail: detail ?? "", completionDate: completionDate)
  }
}
