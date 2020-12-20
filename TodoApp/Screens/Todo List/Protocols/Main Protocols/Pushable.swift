//
//  Pushable.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import UIKit

protocol Pushable {
  func newTodo()
  func goToTodo(with todoItem: TodoItem)
  var pushViewController: ((UIViewController) -> Void)? { get set }
}
