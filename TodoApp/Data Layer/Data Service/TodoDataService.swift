//
//  TodoDataService.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

class TodoDataService: TodoDataServiceProtocol {
  // MARK: - Variables
  /// Stored Variables
  var persistencyService: TodoPersistencyServiceProtocol
  
  // MARK: - Initializer
  init(persistencyService: TodoPersistencyServiceProtocol) {
    self.persistencyService = persistencyService
  }
  
  // MARK: - Data Operations
  /// Create
  final func add(todoItem: TodoItem, _ completion: VoidHandler?) {
    DispatchQueue.main.async {
      self.persistencyService.add(todoItem: todoItem) {
        completion?()
      }
    }
  }
  
  /// Read
  final func todoList(fetchOffset: Int, _ completion: (([TodoItem]) -> Void)?) {
    DispatchQueue.main.async {
      completion?(self.persistencyService.fetchTodoList(fetchOffset: fetchOffset))
    }
  }
  
  /// Update
  final func update(todoItem: TodoItem, _ completion: VoidHandler?) {
    DispatchQueue.main.async {
      self.persistencyService.update(todoItem: todoItem) {
        completion?()
      }
    }
  }
  
  /// Delete
  final func deleteTodoItem(with completionDate: Double, _ completion: VoidHandler?) {
    DispatchQueue.main.async {
      self.persistencyService.deleteTodo(with: completionDate) {
        completion?()
      }
    }
  }
}
