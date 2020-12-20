//
//  TodoDetailViewController.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import UIKit

class TodoDetailViewController: UIViewController {
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var detailTextView: UITextView!
  var viewModel: TodoDetailViewModelProtocol! {
    didSet {
      viewModel.returnToTodoList = returnToTodoList()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  func configureUI() {
    titleTextField.text = viewModel.todoItem?.title
    detailTextView.text = viewModel.todoItem?.detail
  }
  
  @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
    viewModel.completeEditing(title: titleTextField.text, detail: detailTextView.text)
  }
}
