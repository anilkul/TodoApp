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
  
  init(dataService: TodoDataEditable, todoItem: TodoItem? = nil) {
    self.todoItem = todoItem
    self.dataService = dataService
  }
  
  func completeEditing(title: String?, detail: String?) {
    guard let title = title?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
    let detail = detail?.trimmingCharacters(in: .whitespacesAndNewlines) ?? Strings.emptyString
    let completionDate = todoItem?.completionDate ?? Date().timeIntervalSince1970.magnitude
    let todoItem = TodoItem(title: title, detail: detail, completionDate: completionDate)
    add(todoItem)
  }
  
  func add(_ todoItem: TodoItem) {
    dataService.add(todoItem: todoItem, nil)
  }
}
