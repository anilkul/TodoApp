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
    request.sortDescriptors = [NSSortDescriptor(key: "completionDate", ascending: false)]
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
}
