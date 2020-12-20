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
  var viewModel: TodoDetailViewModelProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
    viewModel.completeEditing(title: titleTextField.text, detail: detailTextView.text)
  }
  
}
