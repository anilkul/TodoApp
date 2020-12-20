//
//  TodoDataServiceProtocol.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

protocol TodoDataServiceProtocol: TodoDataEditable, TodoDataListable {
  var persistencyService: TodoPersistencyServiceProtocol { get }
}
