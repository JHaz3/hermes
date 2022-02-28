//
//  Robot.swift
//  GithubGraphQLUITests
//
//  Created by Santiago Carmona on 28/02/22.
//  Copyright © 2022 test. All rights reserved.
//

import XCTest

protocol Robot {
  var screenName: String { get }
  var identifier: XCUIElement { get }

  @discardableResult func checkExists(_ element: XCUIElement, timeout: TimeInterval) -> Self
  @discardableResult func launch() -> Self
}

extension Robot {
  var app: XCUIApplication { XCUIApplication() }

  var identifier: XCUIElement {
      app.descendants(matching: .any).matching(NSPredicate(format: "identifier == '\(screenName)'")).firstMatch
  }

  @discardableResult func checkScreenExists() -> Self {
    checkExists(identifier)
      return self
  }

  @discardableResult func checkExists(_ element: XCUIElement, timeout: TimeInterval = 5) -> Self {
    let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == true"), object: element)
    guard XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed else {
      XCTAssert(false, "Element \(element.label) does not exist")
      return self
    }
    return self
  }

  @discardableResult func launch() -> Self {
    app.launch()
    return self
  }
}
