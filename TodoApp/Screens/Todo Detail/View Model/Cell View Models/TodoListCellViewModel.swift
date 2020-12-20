//
//  TodoListCellViewModel.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

class TodoListCellViewModel: TodoListCellViewModelProtocol {
  // MARK: - Variables
  /// Stored Variables
  var todoItem: TodoItem
  
  // MARK: - Initializer
  init(todoItem: TodoItem) {
    self.todoItem = todoItem
  }
}
