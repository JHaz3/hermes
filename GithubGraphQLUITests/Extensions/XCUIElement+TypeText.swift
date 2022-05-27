//
//  XCUIElement+TypeText.swift
//  GithubGraphQLUITests
//
//  Created by Santiago Carmona on 28/02/22.
//  Copyright © 2022 test. All rights reserved.
//

import XCTest

extension XCUIElement {
  func typeText(_ text: String?, return shouldReturn: Bool) {
    typeText((text ?? "") + (shouldReturn ? "\n" : ""))
  }

  func clearAndEnterText(_ text: String) {
    guard let stringValue = self.value as? String else {
      return
    }
    self.tap()
    let deleteString = stringValue.map { _ in XCUIKeyboardKey.delete.rawValue }.joined(separator: "")
    self.typeText(deleteString)
    self.typeText(text)
  }
}
