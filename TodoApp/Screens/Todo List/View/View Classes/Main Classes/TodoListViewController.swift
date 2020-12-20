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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    router = TodoRouter()
    router.pushViewController = pushViewController()
  }
  
  
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    router.newTodo()
  }
}

