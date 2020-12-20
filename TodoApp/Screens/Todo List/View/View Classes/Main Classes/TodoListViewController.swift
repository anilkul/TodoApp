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
    navigationController?.delegate = self
    viewModel = TodoListViewModel()
    router = TodoRouter()
    createBindings()
    registerCells()
    viewModel.viewIsReady()
  }
  
  func createBindings() {
    router.pushViewController = pushViewController()
    viewModel.updateData = updateData()
  }
  
  func registerCells() {
    tableView.register(UINib(nibName: String(describing: TodoListCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TodoListCell.self))
  }
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    router.newTodo()
  }
}

extension TodoListViewController {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let currentOffset: CGFloat = scrollView.contentOffset.y
    let maximumOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
    guard maximumOffset - currentOffset <= Numbers.scrollViewOffsetThreshold else { return }
    self.viewModel.fetchItems(for: .nextPage)
  }
}

extension TodoListViewController: UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    guard let todoDetailViewController = viewController as? TodoDetailViewController else { return }
    todoDetailViewController.viewModel.reloadList = reloadList()
  }
}

