//
//  Int+Extensions.swift
//  TodoApp
//
//  Created by Mehmet Anıl Kul on 20.12.2020.
//

import Foundation

extension Int {
  func isZeroFor(mod: Int) -> Bool {
    return self % mod == 0
  }
}
