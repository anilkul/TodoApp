//
//  TodoDetailViewModelProtocol.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

protocol TodoDetailViewModelProtocol {
  var todoItem: TodoItem? { get }
  var dataService: TodoDataEditable { get }
  func completeEditing(title: String?, detail: String?)
}
