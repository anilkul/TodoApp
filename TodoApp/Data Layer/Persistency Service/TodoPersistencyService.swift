//
//  TodoPersistencyService.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import CoreData
import Foundation

class TodoPersistencyService: TodoPersistencyServiceProtocol {
  func add(todoItem: TodoItem, _ completion: VoidHandler?) {
    CoreDataStack.shared.persistentContainer.performBackgroundTask { managedObjectContext in
      managedObjectContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
      do {
        let todoEntity = TodoEntity(context: managedObjectContext)
        todoEntity.assignValues(from: todoItem)
        try managedObjectContext.saveIfNeeded()
        completion?()
      } catch {
        fatalError(error.localizedDescription)
      }
    }
  }
}
