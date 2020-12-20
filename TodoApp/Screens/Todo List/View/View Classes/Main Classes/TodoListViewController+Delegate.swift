//
//  TodoListViewController+Delegate.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import UIKit

extension TodoListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let cellViewModel = viewModel.cellViewModels[indexPath.row]
    let action = UIContextualAction(style: .destructive, title: Strings.todoListDeleteSwipeActionTitle) { (_, _, completion) in
      self.deleteTodo(at: indexPath, with: cellViewModel.todoItem.completionDate)
      completion(true)
    }
    return UISwipeActionsConfiguration(actions: [action])
  }
  
  func deleteTodo(at indexPath: IndexPath, with completionDate: Double) {
    self.viewModel.deleteTodo(at: indexPath, with: completionDate)
    self.tableView.reloadData()
  }
}
