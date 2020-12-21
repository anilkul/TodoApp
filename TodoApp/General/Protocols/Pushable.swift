//
//  Pushable.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import UIKit

protocol Pushable {
  /// Closures
  var pushViewController: ((UIViewController) -> Void)? { get set }
  
  /// Functions
  func newTodo()
  func goToTodo(with todoItem: TodoItem)
  
}
