//
//  TodoListViewController.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import UIKit

class TodoListViewController: UIViewController {
  // MARK: - Variables
  /// IBOutlets
  @IBOutlet weak var tableView: UITableView!
  
  /// Stored Variables
  var router: Pushable!
  var viewModel: TodoListViewModelProtocol!
  
  // MARK: - UI Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.delegate = self
    viewModel = TodoListViewModel()
    router = TodoRouter()
    createBindings()
    registerCells()
    viewModel.viewIsReady()
  }
  
  // MARK: - UI Operations
  final func registerCells() {
    tableView.register(UINib(nibName: String(describing: TodoListCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TodoListCell.self))
  }
  
  // MARK: - IBActions
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    router.newTodo()
  }
  
  // MARK: - Binding Operations
  final func createBindings() {
    router.pushViewController = pushViewController()
    viewModel.updateData = updateData()
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

