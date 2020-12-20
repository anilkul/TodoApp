//
//  TodoDataRemovable.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

protocol TodoDataRemovable {
  /// Functions
  func deleteTodoItem(with completionDate: Double, _ completion: VoidHandler?)
}
