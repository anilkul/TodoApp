//
//  TodoListViewController.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import UIKit

class TodoListViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  var router: Pushable!
  var viewModel: TodoListViewModelProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = TodoListViewModel()
    router = TodoRouter()
  }
  
  func createBindings() {
    router.pushViewController = pushViewController()
    viewModel.updateData = updateData()
  }
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    router.newTodo()
  }
}
