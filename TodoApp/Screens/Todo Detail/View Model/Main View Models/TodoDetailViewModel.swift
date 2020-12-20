//
//  TodoDetailViewModel.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

class TodoDetailViewModel: TodoDetailViewModelProtocol {
  var dataService: TodoDataEditable
  var todoItem: TodoItem?
  var isNew: Bool {
    return todoItem == nil
  }
  var header: String {
    return isNew ? Strings.newTodoHeader : Strings.editTodoHeader
  }
  var returnToTodoList: (() -> Void)?
  var reloadList: (() -> Void)?
  
  init(dataService: TodoDataEditable, todoItem: TodoItem? = nil) {
    self.todoItem = todoItem
    self.dataService = dataService
  }
  
  func completeEditing(title: String?, detail: String?) {
    guard let title = title?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
    let detail = detail?.trimmingCharacters(in: .whitespacesAndNewlines) ?? Strings.emptyString
    let completionDate = todoItem?.completionDate ?? Date().timeIntervalSince1970.magnitude
    
    if (title == todoItem?.title && detail == todoItem?.detail) || title.isEmpty { return }
    
    let todoItem = TodoItem(title: title, detail: detail, completionDate: completionDate)
    self.isNew
      ? self.add(todoItem)
      : self.update(todoItem)
  }
  
  func add(_ todoItem: TodoItem) {
    dataService.add(todoItem: todoItem, completionBlock())
  }
  
  func update(_ todoItem: TodoItem) {
    dataService.update(todoItem: todoItem, completionBlock())
  }
  
  func deleteTodoItem() {
    guard let completionDate = todoItem?.completionDate else { return }
    dataService.deleteTodoItem(with: completionDate, completionBlock())
  }
  
  func completionBlock() -> VoidHandler {
    return { [weak self] in
      guard let self = self else { return }
      self.returnToTodoList?()
      self.reloadList?()
    }
  }
}
