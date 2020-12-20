//
//  TodoRouter.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation
import UIKit

class TodoRouter: TodoRoutable {
  var pushViewController: ((UIViewController) -> Void)?

  func newTodo() {
    let todoDetailViewController: TodoDetailViewController = ViewControllerMaker.todoDetailViewController()
    pushViewController?(todoDetailViewController)
  }
  
  func goToTodo(with todoItem: TodoItem) {
    let todoDetailViewController: TodoDetailViewController = ViewControllerMaker.todoDetailViewController(todoItem: todoItem)
    pushViewController?(todoDetailViewController)
  }
}
