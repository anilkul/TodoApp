//
//  TodoListViewModel.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

class TodoListViewModel: TodoListViewModelProtocol {
  var cellViewModels: [TodoListCellViewModelProtocol]
  var dataService: TodoDataListable
  var updateData: VoidHandler?
  var fetchOffset: Int
  
  init() {
    cellViewModels = []
    fetchOffset = Numbers.initialFetchOffset
    dataService = TodoDataService(persistencyService: TodoPersistencyService())
  }
  
  func viewIsReady() {
    fetchItems(for: .initialPage)
  }
  
  func fetchItems(for paginationType: PaginationType) {
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
  
  func parseCellViewModels() {
    dataService.todoList(fetchOffset: fetchOffset) { [weak self] todoList in
      guard let self = self else { return }
      todoList.forEach { self.cellViewModels.append(self.makeTodoListCellViewModel(with: $0)) }
      self.updateData?()
    }
  }
  
  func makeTodoListCellViewModel(with todoItem: TodoItem) -> TodoListCellViewModelProtocol {
    return TodoListCellViewModel(todoItem: todoItem)
  }
}
