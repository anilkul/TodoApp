//
//  TodoPersistencyService.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import CoreData
import Foundation

class TodoPersistencyService: TodoPersistencyServiceProtocol {
  // MARK: - Variables
  /// Computed Variables
  var managedObjectContext: NSManagedObjectContext {
    return CoreDataStack.shared.persistentContainer.viewContext
  }
  
  // MARK: - Core Data Operations
  /// Create
  final func add(todoItem: TodoItem, _ completion: VoidHandler?) {
    CoreDataStack.shared.persistentContainer.performBackgroundTask { managedObjectContext in
      managedObjectContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
      do {
        let todoEntity = TodoEntity(context: managedObjectContext)
        todoEntity.assignValues(from: todoItem)
        try managedObjectContext.saveIfNeeded()
        completion?()
      } catch {
        
        fatalError(ErrorLogger.PersistencyServiceError.couldNotAdd.errorMessage(lineNumber: "\(#line)", methodName: "\(#function)", fileName: "\(#file)", errorDescription: error.localizedDescription))
      }
    }
  }
  
  /// Read
  final func fetchTodoList(fetchOffset: Int) -> [TodoItem] {
    let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
    request.sortDescriptors = TodoEntity.SortDescriptors.fetch.sortDescriptors
    request.returnsObjectsAsFaults = false
    request.fetchLimit = Numbers.pageSize
    request.fetchOffset = fetchOffset
    do {
      let todoList = try managedObjectContext.fetch(request)
      return todoList.compactMap(\.todoItem)
    } catch {
      print(ErrorLogger.PersistencyServiceError.couldNotFetch.errorMessage(lineNumber: "\(#line)", methodName: "\(#function)", fileName: "\(#file)"))
      return []
    }
  }
  
  /// Update
  final func update(todoItem: TodoItem, _ completion: VoidHandler?) {
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
        fatalError(ErrorLogger.PersistencyServiceError.couldNotUpdate.errorMessage(lineNumber: "\(#line)", methodName: "\(#function)", fileName: "\(#file)", errorDescription: error.localizedDescription))
      }
    }
  }
  
  /// Delete
  final func deleteTodo(with completionDate: Double, completion: VoidHandler?) {
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
        fatalError(ErrorLogger.PersistencyServiceError.couldNotDelete.errorMessage(lineNumber: "\(#line)", methodName: "\(#function)", fileName: "\(#file)", errorDescription: error.localizedDescription))
      }
    }
  }
}
