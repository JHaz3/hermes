@testable import GithubGraphQL
import XCTest
import Combine

class GithubGraphQLTests: XCTestCase, ViewModelDelegate {
    func listLoadedSuccessfully() {
        print("Test")
    }
    
    func encountered(_ error: Error) {
        print("Test")
    }
    

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
      let mockedResponse = SearchRepositoriesQuery.Data(search: .init(
        pageInfo: .init(startCursor: "startCursor", endCursor: nil, hasNextPage: false, hasPreviousPage: false),
        edges: makeEdges(count: 3)
      ))
      let viewModel = ViewModel(client: MockGraphQLClient<SearchRepositoriesQuery>(response: mockedResponse), delegate: self)

      /* add assertions to validate view model state after making requests */
        viewModel.list.removeAll()
        
        XCTAssertTrue(viewModel.list.isEmpty)
        viewModel.search(phrase: <#T##String#>)
        viewModel.search(phrase: mockedResponse)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }

    }

  private func createMockResponseViewModel(count: UInt) -> RepositoryListViewModel {
    let mockedResponse = SearchRepositoriesQuery.Data(search: .init(
      pageInfo: .init(startCursor: "startCursor", endCursor: nil, hasNextPage: false, hasPreviousPage: false),
      edges: makeEdges(count: count)
    ))
    return RepositoryListViewModel(client: MockGraphQLClient<SearchRepositoriesQuery>(response: mockedResponse))    
  }
}
