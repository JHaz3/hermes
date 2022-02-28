@testable import GithubGraphQL
import XCTest
import Combine

class GithubGraphQLTests: XCTestCase {
    func testTypeSomethingToStartSearchingMessageAppears() {
      let viewModel = createMockResponseViewModel(count: 3)
      viewModel.phrase = ""
      XCTAssertNotNil(viewModel.disclaimer)
      XCTAssertEqual(viewModel.disclaimer?.title, "🕵🏿‍♂️ Type something to start searching..")
      XCTAssertNil(viewModel.disclaimer?.subtitle)
    }

  private func createMockResponseViewModel(count: UInt) -> RepositoryListViewModel {
    let mockedResponse = SearchRepositoriesQuery.Data(search: .init(
      pageInfo: .init(startCursor: "startCursor", endCursor: nil, hasNextPage: false, hasPreviousPage: false),
      edges: makeEdges(count: count)
    ))
    return RepositoryListViewModel(client: MockGraphQLClient<SearchRepositoriesQuery>(response: mockedResponse))    
  }
}
