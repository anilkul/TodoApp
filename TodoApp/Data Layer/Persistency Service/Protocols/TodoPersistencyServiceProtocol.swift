//
//  TodoPersistencyServiceProtocol.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

protocol TodoPersistencyServiceProtocol {
  func add(todoItem: TodoItem, _ completion: VoidHandler?)
  func fetchTodoList(fetchOffset: Int) -> [TodoItem]
}
