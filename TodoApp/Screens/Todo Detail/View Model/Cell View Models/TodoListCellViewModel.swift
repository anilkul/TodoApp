//
//  TodoListCellViewModel.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

class TodoListCellViewModel: TodoListCellViewModelProtocol {
  var todoItem: TodoItem
  
  init(todoItem: TodoItem) {
    self.todoItem = todoItem
  }
}
