//
//  RepositoryListRobot.swift
//  GithubGraphQLUITests
//
//  Created by Santiago Carmona on 28/02/22.
//  Copyright © 2022 test. All rights reserved.
//

import XCTest

class RepositoryListRobot: Robot {
  let screenName: String = RobotIdentifier.repositoryListView.rawValue

  private lazy var disclaimerView = app.otherElements["RepositoryListViewDisclaimerScreen"].firstMatch
  private lazy var rows = app.otherElements.matching(identifier: "RepositoryRow").allElementsBoundByIndex
  private lazy var searchTextField = app.textFields["RepositorySearchText"].firstMatch

  @discardableResult func checkDisclaimerViewExists() -> Self {
    checkExists(disclaimerView)
  }

  @discardableResult func checkRepositoryRowsAreDisplayed() -> Self {
    XCTAssertGreaterThan(rows.count, 0)
    return self
  }

  @discardableResult func searchRepository(_ text: String) -> Self {
    checkExists(searchTextField)
    searchTextField.clearAndEnterText(text)
    return self
  }

  @discardableResult func checkSearchText(_ text: String) -> Self {
    checkExists(searchTextField)
    XCTAssertEqual(searchTextField.value as? String, text)
    return self
  }
}
