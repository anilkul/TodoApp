//
//  NSManagedObjectContext+Extensions.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
  
  /// Only performs a save if there are changes to commit.
  /// - Returns: `true` if a save was needed. Otherwise, `false`.
  @discardableResult public func saveIfNeeded() throws -> Bool {
    guard hasChanges else { return false }
    try save()
    return true
  }
}
