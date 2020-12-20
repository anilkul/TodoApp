//
//  TodoListViewController+Bindings.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation
import UIKit

extension TodoListViewController {
  final func pushViewController() -> (UIViewController) -> Void {
    return { [weak self] viewController in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.navigationController?.pushViewController(viewController, animated: true)
      }
    }
  }
  
  final func updateData() -> () -> Void {
    return { [weak self] in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  final func reloadList() -> (() -> Void) {
    return { [weak self] in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.viewModel.fetchItems(for: .initialPage)
        self.tableView.reloadData()
      }
    }
  }
}
