//
//  TodoListViewController+Bindings.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation
import UIKit

extension TodoListViewController {
  func pushViewController() -> (UIViewController) -> Void {
    return { [weak self] viewController in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.navigationController?.pushViewController(viewController, animated: true)
      }
    }
  }
}
