import XCTest

class GithubGraphQLUITests: XCTestCase {
  func testInitialRepositoriesAreDisplayedForGraphqlWord() {
    RepositoryListRobot()
      .launch()
      .checkSearchText("graphql")
      .checkRepositoryRowsAreDisplayed()
  }

  func testDisclaimerScreenIsDisplayedWhenSearchTextIsEmpty() {
    RepositoryListRobot()
      .launch()
      .searchRepository("")
      .checkDisclaimerViewExists()
  }
}
