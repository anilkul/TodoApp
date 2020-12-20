//
//  TodoRouter.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation
import UIKit

class TodoRouter: TodoRoutable {
  // MARK: - Variables
  /// Closures
  var pushViewController: ((UIViewController) -> Void)?

  // MARK: - Routing Operations
  final func newTodo() {
    let todoDetailViewController: TodoDetailViewController = ViewControllerMaker.todoDetailViewController()
    pushViewController?(todoDetailViewController)
  }
  
  final func goToTodo(with todoItem: TodoItem) {
    let todoDetailViewController: TodoDetailViewController = ViewControllerMaker.todoDetailViewController(todoItem: todoItem)
    pushViewController?(todoDetailViewController)
  }
}
