//
//  TodoDetailViewController+Bindings.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

extension TodoDetailViewController {
  func returnToTodoList() -> () -> Void {
    return { [weak self] in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.navigationController?.popToRootViewController(animated: true)
      }
    }
  }
}
