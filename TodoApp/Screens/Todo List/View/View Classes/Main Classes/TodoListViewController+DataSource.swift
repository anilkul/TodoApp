//
//  TodoListViewController+DataSource.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation
import UIKit

extension TodoListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.cellViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellViewModel = viewModel.cellViewModels[indexPath.row]
    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TodoListCell.self), for: indexPath) as? TodoListCell else {
      fatalError("Todo List Cell could not be created")
    }
    cell.configureCell(with: cellViewModel, router: router)
    return cell
  }
}
