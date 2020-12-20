//
//  TodoPersistencyService.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import CoreData
import Foundation

class TodoPersistencyService: TodoPersistencyServiceProtocol {
  var managedObjectContext: NSManagedObjectContext {
    return CoreDataStack.shared.persistentContainer.viewContext
  }
  
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
  
  func fetchTodoList(fetchOffset: Int) -> [TodoItem] {
    let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
    request.sortDescriptors = TodoEntity.SortDescriptors.fetch.sortDescriptors
    request.returnsObjectsAsFaults = false
    request.fetchLimit = Numbers.pageSize
    request.fetchOffset = fetchOffset
    do {
      let todoList = try managedObjectContext.fetch(request)
      return todoList.compactMap(\.todoItem)
    } catch {
      print(error)
      return []
    }
  }
  
  func update(todoItem: TodoItem, _ completion: VoidHandler?) {
    CoreDataStack.shared.persistentContainer.performBackgroundTask { managedObjectContext in
      managedObjectContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
      let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
      request.predicate = TodoEntity.Predicate.update(completionDate: todoItem.completionDate).query
      request.returnsObjectsAsFaults = false
      do {
        let todoItemToUpdate = try managedObjectContext.fetch(request)
        todoItemToUpdate.first?.assignValues(from: todoItem)
        try managedObjectContext.saveIfNeeded()
        completion?()
      } catch {
        fatalError(error.localizedDescription)
      }
    }
  }
  
  func deleteTodo(with completionDate: Double, completion: (() -> Void)? = nil) {
    CoreDataStack.shared.persistentContainer.performBackgroundTask { managedObjectContext in
      let request: NSFetchRequest<NSFetchRequestResult> = TodoEntity.fetchRequest()
      request.predicate = TodoEntity.Predicate.delete(completionDate: completionDate).query
      request.returnsObjectsAsFaults = false
      let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
      do {
        try managedObjectContext.execute(batchDeleteRequest)
        try managedObjectContext.saveIfNeeded()
        completion?()
      } catch {
        fatalError(error.localizedDescription)
      }
    }
  }
}
