//
//  Pushable.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import UIKit

protocol Pushable {
  func newTodo()
  var pushViewController: ((UIViewController) -> Void)? { get set }
}
