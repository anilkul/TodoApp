//
//  TodoListViewModelProtocol.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

protocol TodoListViewModelProtocol {
  /// Stored Variables
  var cellViewModels: [TodoListCellViewModelProtocol] { get set }
  var dataService: TodoDataListable { get }
  
  /// Closures
  var updateData: VoidHandler? { get set }
  
  /// Functions
  func viewIsReady()
  func fetchItems(for paginationType: PaginationType)
  func deleteTodo(at indexPath: IndexPath, with completionDate: Double)
}
