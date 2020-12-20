//
//  TodoDetailViewController.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import UIKit

class TodoDetailViewController: UIViewController {
  // MARK: - Variables
  /// IBOutlets
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var detailTextView: UITextView!
  
  /// Stored Variables
  var viewModel: TodoDetailViewModelProtocol! {
    didSet {
      viewModel.returnToTodoList = returnToTodoList()
    }
  }
  
  // MARK: - UI Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  // MARK: - UI Operations
  final func configureUI() {
    navigationItem.title = viewModel.header
    titleTextField.text = viewModel.todoItem?.title
    detailTextView.text = viewModel.todoItem?.detail
    detailTextView.layer.cornerRadius = Numbers.textViewDefaultCornerRadius
    detailTextView.layer.borderWidth = Numbers.textViewDefaultBorderWidth
    detailTextView.layer.borderColor = Colors.textViewDefaultBorderColor
    titleTextField.becomeFirstResponder()
    addKeyboardDismissGesture()
    addDeleteButtonIfNeeded()
  }
  
  final func addKeyboardDismissGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    self.view.addGestureRecognizer(tapGesture)
  }
  
  final func addDeleteButtonIfNeeded() {
    if viewModel.isNew { return }
    let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonPressed(_:)))
    navigationItem.rightBarButtonItems?.append(deleteButton)
  }
  
  @objc final func dismissKeyboard() {
    self.view.endEditing(true)
  }
  
  @objc final func deleteButtonPressed(_ sender: UIBarButtonItem) {
    viewModel.deleteTodoItem()
  }
  
  // MARK: - IBActions
  @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
    viewModel.completeEditing(title: titleTextField.text, detail: detailTextView.text)
  }
}
