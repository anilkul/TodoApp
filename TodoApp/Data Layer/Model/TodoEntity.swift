//
//  TodoEntity.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation
import CoreData

// Entity here that conforms Decodable protocol may seem like Interface Segregation but I wanted to show that this could be used in network layer in future.
// Make sure you set your decoder's userInfo key for our managed object context in CoreDataStack if you want to use this model for network requests as well
/// Ex: decoder.userInfo[CodingUserInfoKey.managedObjectContext] = myPersistentContainer.viewContext
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

extension TodoEntity {
  enum Predicate {
    case update(completionDate: Double), delete(completionDate: Double)
    
    var query: NSPredicate {
      switch self {
      case .update(let completionDate):
        return NSPredicate(format: "completionDate == %lf", completionDate)
      case .delete(let completionDate):
        return NSPredicate(format: "completionDate == %lf", completionDate)
      }
    }
  }
  
  enum SortDescriptors {
    case fetch
    
    var sortDescriptors: [NSSortDescriptor] {
      switch self {
      case .fetch:
        return [NSSortDescriptor(key: "completionDate", ascending: false)]
      }
    }
  }
}
