//
//  TodoListCell.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import UIKit

class TodoListCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  var router: Pushable!
  var cellViewModel: TodoListCellViewModelProtocol!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configureCell(with viewModel: TodoListCellViewModelProtocol, router: Pushable) {
    self.cellViewModel = viewModel
    titleLabel.text = viewModel.todoItem.title
    self.router = router
  }
  
  @IBAction func todoItemPressed(_ sender: UIButton) {
    router.goToTodo(with: cellViewModel.todoItem)
  }
}
