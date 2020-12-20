//
//  ErrorLogger.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

struct ErrorLogger {
  enum PersistencyServiceError {
    case couldNotAdd
    case couldNotFetch
    case couldNotUpdate
    case couldNotDelete
    case unresolved
    
    func errorMessage(lineNumber: String, methodName: String, fileName: String, errorDescription: String = Strings.emptyString) -> String {
      switch self {
      case .unresolved:
        return "\(ErrorLogger.errorHeader)Unresolved Core Data error \(ErrorLogger.errorLocation(lineNumber: lineNumber, methodName: methodName, fileName: fileName, errorDescription: errorDescription))"
      default:
        return "\(ErrorLogger.errorHeader)Could not\(specificAction) database.\(ErrorLogger.errorLocation(lineNumber: lineNumber, methodName: methodName, fileName: fileName, errorDescription: errorDescription))"
      }
    }
    
    private var specificAction: String {
      switch self {
      case .couldNotAdd:
        return " add item to"
      case .couldNotFetch:
        return " fetch items from"
      case .couldNotUpdate:
        return " update item in"
      case .couldNotDelete:
        return " delete item from"
      default: return Strings.emptyString
      }
    }
  }
  
  enum ViewClassError {
    case cellCouldNotBeCreated(className: String)
    
    func errorMessage(lineNumber: String, methodName: String, fileName: String, errorDescription: String = Strings.emptyString) -> String {
      switch self {
      case .cellCouldNotBeCreated(let className):
        return "\(ErrorLogger.errorHeader) \(className) could not be created. \(ErrorLogger.errorLocation(lineNumber: lineNumber, methodName: methodName, fileName: fileName, errorDescription: errorDescription))"
      }
    }
  }
  
  static var errorHeader: String {
    return "❌!!!ERROR!!!❌\n"
  }
  
  static func errorLocation(lineNumber: String, methodName: String, fileName: String, errorDescription: String) -> String {
    var errorLocationMessage = "Error occured in \nLine Number: \(lineNumber)\nMethod Name: \(methodName)\nFile Name: \(fileName)"
    if !errorDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      errorLocationMessage.append("\n⭕️ Custom Error Description: \(errorDescription)")
    }
    return errorLocationMessage
  }
}
