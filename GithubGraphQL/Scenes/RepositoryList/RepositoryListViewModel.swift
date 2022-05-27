import Apollo
import SwiftUI

final class RepositoryListViewModel: ObservableObject {
  var imageCache = ImageCacheService()
  @Published var isLoading: Bool = false
  @Published var disclaimer: Disclaimer?
  @Published var values: [RepositoryDetails] = []
  @Published var phrase: String = "" {
    didSet {
      guard phrase.isEmpty else {
        return
      }
      disclaimer = Disclaimer(title: "🕵🏿‍♂️ Type something to start searching..", subtitle: nil)
    }
  }

  private var filter: SearchRepositoriesQuery.Filter? {
    guard let endCursor = pageInfo?.endCursor else {
      return nil
    }
    return .after(.init(rawValue: endCursor))
  }
  private var pageInfo: SearchRepositoriesQuery.Data.Search.PageInfo?
  private var cancellable: Cancellable?

  private let client: GraphQLClient
  init(client: GraphQLClient = ApolloClient.shared) {
    self.client = client
    self.phrase = "graphql"
    refresh()
  }

  func fetch(lastValue: RepositoryDetails) {
    guard isLoading == false else {
      return
    }

    guard values.last == lastValue  else {
        return
    }

    guard pageInfo?.hasNextPage == true else {
        return
    }

    cancellable?.cancel()
    fetch()
    disclaimer = nil
  }

  func refresh() {    
    values = []
    pageInfo = nil
    fetch()
    disclaimer = nil
  }

  private func fetch() {
    isLoading = true
    cancellable = self.client.searchRepositories(mentioning: phrase, filter: filter) { response in
      switch response {
      case let .failure(error):
        self.disclaimer = Disclaimer(title: "Ups! Something went wrong", subtitle: error.localizedDescription)
      case let .success(results):
        self.pageInfo = results.pageInfo
        self.values.append(contentsOf: results.repos)
        self.cancellable?.cancel()
        if self.values.isEmpty {
          self.disclaimer = Disclaimer(title: "No results for: \(self.phrase)", subtitle: "Please search another word")
        }
      }
      self.isLoading = false
    }
  }
}
