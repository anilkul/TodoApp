//
//  TodoListViewModel.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation
// MARK: - Variables
/// Stored Variables
class TodoListViewModel: TodoListViewModelProtocol {
  
  var cellViewModels: [TodoListCellViewModelProtocol]
  var dataService: TodoDataListable
  var updateData: VoidHandler?
  var fetchOffset: Int
  
  // MARK: - Initializer
  init() {
    cellViewModels = []
    fetchOffset = Numbers.initialFetchOffset
    dataService = TodoDataService(persistencyService: TodoPersistencyService())
  }
  
  final func viewIsReady() {
    fetchItems(for: .initialPage)
  }
  
  // MARK: - Data Operations
  final func fetchItems(for paginationType: PaginationType) {
    switch paginationType {
    case .initialPage:
      guard cellViewModels.count >= fetchOffset else { return }
      fetchOffset = Numbers.initialFetchOffset
      cellViewModels.removeAll()
    case .nextPage:
      guard cellViewModels.count >= fetchOffset && cellViewModels.count.isZeroFor(mod: Numbers.pageSize) else { return }
      fetchOffset += Numbers.pageSize
    }
    parseCellViewModels()
  }
  
  final func parseCellViewModels() {
    dataService.todoList(fetchOffset: fetchOffset) { [weak self] todoList in
      guard let self = self else { return }
      todoList.forEach { self.cellViewModels.append(self.makeTodoListCellViewModel(with: $0)) }
      self.updateData?()
    }
  }
  
  final func makeTodoListCellViewModel(with todoItem: TodoItem) -> TodoListCellViewModelProtocol {
    return TodoListCellViewModel(todoItem: todoItem)
  }
  
  final func deleteTodo(at indexPath: IndexPath, with completionDate: Double) {
    dataService.deleteTodoItem(with: completionDate) { [weak self] in
      guard let self = self else { return }
      // Can reload list again from the db when got to list screen but this can work here without much effort.
      self.cellViewModels.remove(at: indexPath.row)
      self.updateData?()
    }
  }
}
