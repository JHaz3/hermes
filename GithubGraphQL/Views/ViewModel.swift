import Apollo
import Dispatch

protocol ViewModelDelegate: AnyObject {
    func listLoadedSuccessfully()
    func encountered(_ error: Error)
}

final class ViewModel {
    private let client: GraphQLClient
    weak var delegate: ViewModelDelegate?
    
    init(client: GraphQLClient = ApolloClient.shared, delegate: ViewModelDelegate) {
        self.client = client
        self.delegate = delegate
    }
    
    var list: [RepositoryDetails] = []

    func search(phrase: String) {
        /*
         example search of a given phrase, using default searching parameters
         */
        
        self.client.searchRepositories(mentioning: phrase) { [weak self] response in
            switch response {
            case let .failure(error):
                print(error)
                
            case let .success(results):
                let pageInfo = results.pageInfo
                print("pageInfo: \n")
                print("hasNextPage: \(pageInfo.hasNextPage)")
                print("hasPreviousPage: \(pageInfo.hasPreviousPage)")
                print("startCursor: \(String(describing: pageInfo.startCursor))")
                print("endCursor: \(String(describing: pageInfo.endCursor))")
                print("\n")
                
                
                results.repos.forEach { repository in
                    print("Name: \(repository.name)")
                    print("Path: \(repository.url)")
                    print("Owner: \(repository.owner.login)")
                    print("avatar: \(repository.owner.avatarUrl)")
                    print("Stars: \(repository.stargazers.totalCount)")
                    print("\n")
                    
                    results.repos.forEach { repo in
                        self?.list.append(repo)
                    }
                    DispatchQueue.main.async {
                        self?.delegate?.listLoadedSuccessfully()
                        
                    }
                }
            }
        }
    }
}
