//
//  TodoListCell.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import UIKit

class TodoListCell: UITableViewCell {
  // MARK: - Variables
  /// IBOutlets
  @IBOutlet weak var titleLabel: UILabel!
  
  /// Stored Variables
  var router: Pushable!
  var cellViewModel: TodoListCellViewModelProtocol!
  
  // MARK: - UI Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: - UI Operations
  final func configureCell(with viewModel: TodoListCellViewModelProtocol, router: Pushable) {
    self.cellViewModel = viewModel
    titleLabel.text = viewModel.todoItem.title
    self.router = router
  }
  
  // MARK: - IBActions
  @IBAction func todoItemPressed(_ sender: UIButton) {
    router.goToTodo(with: cellViewModel.todoItem)
  }
}
