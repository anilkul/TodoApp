//
//  TodoListViewModelProtocol.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

protocol TodoListViewModelProtocol {
  var cellViewModels: [TodoListCellViewModelProtocol] { get set }
  var dataService: TodoDataListable { get }
  
  var updateData: VoidHandler? { get set }
  
  func viewIsReady()
  func fetchItems(for paginationType: PaginationType)
  func deleteTodo(at indexPath: IndexPath, with completionDate: Double)
}
