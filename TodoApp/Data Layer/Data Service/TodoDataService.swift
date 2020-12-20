//
//  TodoDataService.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

class TodoDataService: TodoDataServiceProtocol {
  var persistencyService: TodoPersistencyServiceProtocol
  
  init(persistencyService: TodoPersistencyServiceProtocol) {
    self.persistencyService = persistencyService
  }
  
  func add(todoItem: TodoItem, _ completion: VoidHandler?) {
    DispatchQueue.main.async {
      self.persistencyService.add(todoItem: todoItem) {
        completion?()
      }
    }
  }
  
  func todoList(fetchOffset: Int, _ completion: (([TodoItem]) -> Void)?) {
    DispatchQueue.main.async {
      completion?(self.persistencyService.fetchTodoList(fetchOffset: fetchOffset))
    }
  }
}
