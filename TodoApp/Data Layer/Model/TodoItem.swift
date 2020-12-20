//
//  TodoItem.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

// A presentation model for Todo Entity
struct TodoItem {
  var title: String = Strings.emptyString
  var detail: String = Strings.emptyString
  var completionDate: Double = 0
}
