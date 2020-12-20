//
//  TodoDataEditable.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

protocol TodoDataEditable {
  func add(todoItem: TodoItem, _ completion: VoidHandler?)
}
