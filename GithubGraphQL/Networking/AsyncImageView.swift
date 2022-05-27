//
//  AsyncImageView.swift
//  GithubGraphQL
//
//  Created by Jake Haslam on 5/26/22.
//  Copyright © 2022 test. All rights reserved.
//

import UIKit

class AsyncImageView: UIImageView, APIDataProvidable {
    
    func setImage(using urlRequest: URLRequest) {
        perform(urlRequest) { [weak self] result in
            DispatchQueue.main.async {
                guard let imageData = try? result.get() else { return }
                self?.image = UIImage(data: imageData)
            }
        }
    }
}

protocol APIDataProvidable {
    func perform(_ request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

extension APIDataProvidable {
    func perform(_ request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestError(error)))
            }
            // TODO: - Handle response
            if let response = response as? HTTPURLResponse {
                dump(response)
            }
            guard let data = data else {
                completion(.failure(.couldNotUnwrap))
                return
            }
            completion(.success(data))
        }.resume()
    }
}

enum NetworkError: Error, LocalizedError {
    case unexpectedError
    case requestError(Error)
    case badURL(URL?)
    case couldNotUnwrap
    case errorDecoding(Error)
    
    var localizedDescription: String {
        switch self {
        case .requestError(let error):
            return "Error performing the task: \(error.localizedDescription)"
        case .badURL:
            return "Unable to make the request with the given URL"
        case .couldNotUnwrap:
            return "Error parsing requested data"
        case .errorDecoding:
            return "Error ecountered when decoding the data"
        case .unexpectedError:
            return "Hmm.. Something went wrong"
        }
    }
}
