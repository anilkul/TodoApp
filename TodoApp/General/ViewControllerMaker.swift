//
//  ViewControllerMaker.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation
import UIKit

struct ViewControllerMaker {
  // MARK: - Generation Operations
  static func make(with identifier: String, from storyboard: UIStoryboard) -> UIViewController? {
    return storyboard.instantiateViewController(withIdentifier: identifier)
  }
  
  @discardableResult
  static func defineViewController<T: UIViewController>(with identifier: String,
                                                        from storyboard: UIStoryboard,
                                                        of type: T.Type? = nil) -> T {
    
    guard let viewController = make(with: identifier, from: storyboard) as? T else {
      fatalError("Could not define view controller with identifier: \(identifier), from storyboard: \(storyboard)")
    }
    return viewController
  }
  
  static func todoDetailViewController(todoItem: TodoItem? = nil) -> TodoDetailViewController {
    let todoDetailViewController = defineViewController(with: "TodoDetailViewController", from: UIStoryboard(name: "Main", bundle: nil), of: TodoDetailViewController.self)
    todoDetailViewController.viewModel =  TodoDetailViewModel(dataService: TodoDataService(persistencyService: TodoPersistencyService()), todoItem: todoItem)
    return todoDetailViewController
  }
}
