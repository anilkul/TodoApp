//
//  TodoDetailViewModelProtocol.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

protocol TodoDetailViewModelProtocol {
  /// Stored Variables
  var todoItem: TodoItem? { get }
  var dataService: TodoDataEditable { get }
  var isNew: Bool { get }
  var header: String { get }
  
  /// Closures
  var returnToTodoList: (() -> Void)? { get set }
  var reloadList: (() -> Void)? { get set }
  
  /// Functions
  func completeEditing(title: String?, detail: String?)
  func deleteTodoItem()
}
